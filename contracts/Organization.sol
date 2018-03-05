pragma solidity ^0.4.19;

import "./Ownership/Ownable.sol";
import "./ConfigurationInterface.sol";
import "./OrganizationInterface.sol";
import "./Proposals/ProposalInterface.sol";
import "./Voting/VotingPowerInterface.sol";
import "./Voting/VotingRightsInterface.sol";
import "./Registries/ModuleRegistryInterface.sol";
import "./ElectoralSystems/ElectoralSystemInterface.sol";
import "./Managers/ProposalManagerInterface.sol";

contract Organization is OrganizationInterface, Ownable {

    uint constant PERCENTAGE_BASE = 10**18;

    ConfigurationInterface public configuration;
    ModuleRegistryInterface public modules;
    ProposalManagerInterface public proposalManager;
    ElectoralSystemInterface public electoralSystem;

    event ProposalCreated(uint id, address proposal, address indexed creator);
    event ProposalExecuted(uint id);

    function Organization(
        ConfigurationInterface _configuration,
        ProposalManagerInterface _proposalManager,
        ModuleRegistryInterface _modules
    )
    public
    {
        configuration = _configuration;
        proposalManager = _proposalManager;
        modules = _modules;
    }

    /// @dev Votes on a proposal.
    /// @param proposalId ID of the proposal to vote on.
    /// @param choice Option selected for vote.
    /// @param data Additional data required for voting, eg. Electoral System.
    function vote(uint proposalId, uint choice, bytes data) external {
        require(proposalManager.isApproved(proposalId));

        ProposalInterface proposal = ProposalInterface(proposalManager.getProposal(proposalId));

        require(votingRights().canVote(msg.sender, proposal));
        require(proposal.isVoting());
        require(proposal.ballot().isValidChoice(choice));

        uint weight = votingPower().votingWeightOf(msg.sender, proposal);
        proposal.ballot().vote(msg.sender, choice, weight);
    }

    /// @dev Reverses a vote on a proposal.
    /// @param proposalId ID of the proposal to undo vote on.
    function unvote(uint proposalId) external {
        ProposalInterface proposal = ProposalInterface(proposalManager.getProposal(proposalId));

        require(proposal.isVoting());

        proposal.ballot().unvote(msg.sender);
    }

    /// @dev Approves a proposal.
    /// @param proposal ID of the proposal we want to approve
    function approve(uint proposal) external {
        require(votingRights().canApprove(msg.sender));
        proposalManager.approve(proposal);
    }

    // @todo this isn't smart, proposal contract should be created here. Pass Ballot, Executor etc.
    /// @dev Creates a new proposal and stores it.
    /// @param proposalAddress Address of the new proposal.
    function propose(address proposalAddress) external {
        require(votingRights().canPropose(msg.sender));

        // @todo we will need to hash the code to see if it matches the stored hash
        ProposalInterface proposal = ProposalInterface(proposal);

        uint id = proposalManager.add(msg.sender, proposalAddress);

        if (!votingRights().requiresApproval(id)) {
            proposalManager.approve(id);
        }

        ProposalCreated(id, proposalAddress, msg.sender);
    }

    /// @dev Executes a proposal if it has passed.
    /// @param id ID of the proposal to execute.
    function execute(uint id) external {
        ProposalInterface proposal = ProposalInterface(proposalManager.getProposal(id));

        require(proposal.isAccepted());
        require(proposal.canExecute());

        proposal.execute();

        ProposalExecuted(id);
    }

    /// @dev Creates a new voting round if now winner was found.
    /// @param id ID of the proposal.
    function newVotingRound(uint id) external {
        BallotInterface ballot = ProposalInterface(proposalManager.getProposal(id)).ballot();

        require(!electoralSystem.hasWinner(ballot));

        uint[2] memory candidates = electoralSystem.topCandidates(ballot);
        ballot.nextRound(candidates);
    }

    /// @dev Tallies votes and submits count to proposal.
    /// @param id Id of the proposal to tally.
    function tally(uint id) external {
        require(quorumReached(id));
        ProposalInterface(proposalManager.getProposal(id)).setWinningOption(winningOption(id));
    }

    /// @dev Validates if the reached quorum is greater than or equal to the maximum.
    /// @param id Id of the proposal.
    /// @return true/false if quorum was reached.
    function quorumReached(uint id) public view returns (bool) {
        uint maxQuorum = votingPower().maximumQuorum();
        uint quorum = ProposalInterface(proposalManager.getProposal(id)).ballot().quorum();
        uint minimumQuorum = configuration.get("minQuorum");

        return ((quorum * PERCENTAGE_BASE) / maxQuorum) >= minimumQuorum;
    }

    /// @dev Selects the winning option using the electoral system.
    /// @param id Id of the proposal
    /// @return id of the winning option
    function winningOption(uint id) public view returns (uint) {
        return electoralSystem.winner(ProposalInterface(proposalManager.getProposal(id)).ballot());
    }

    function votingRights() public view returns (VotingRightsInterface) {
        return VotingRightsInterface(modules.getModule("rights"));
    }

    function votingPower() public view returns (VotingPowerInterface) {
        return VotingPowerInterface(modules.getModule("strategy"));
    }
}
