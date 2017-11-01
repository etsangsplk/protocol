pragma solidity 0.4.18;

import "./Ownership/Ownable.sol";
import "./ConfigurationInterface.sol";
import "./OrganizationInterface.sol";
import "./Proposals/ProposalInterface.sol";
import "./Voting/VotingPowerInterface.sol";
import "./Voting/VotingRightsInterface.sol";
import "./Registries/ModuleRegistryInterface.sol";
import "./ElectoralSystems/ElectoralSystemInterface.sol";
import "./Managers/ProposalManagerInterface.sol";
import "./Managers/VotingManagerInterface.sol";

contract Organization is OrganizationInterface, Ownable {

    ConfigurationInterface public configuration;
    ModuleRegistryInterface public modules;
    ProposalManagerInterface public proposalManager;
    VotingManagerInterface public votingManager;
    ElectoralSystemInterface public electoralSystem;

    event ProposalCreated(uint id, address proposal, address indexed creator);
    event ProposalExecuted(uint id);

    function Organization(
        ConfigurationInterface _configuration,
        ProposalManagerInterface _proposalManager,
        VotingManagerInterface _votingManager,
        ModuleRegistryInterface _modules
    )
    public
    {
        configuration = _configuration;
        proposalManager = _proposalManager;
        votingManager = _votingManager;
        modules = _modules;
    }

    /// @dev Votes on a proposal.
    /// @param proposal ID of the proposal to vote on.
    /// @param choice Option selected for vote.
    function vote(uint proposal, uint choice) external {
        require(proposalManager.isApproved(proposal));
        require(votingRights().canVote(msg.sender));
        require(ProposalInterface(proposalManager.getProposal(proposal)).ballot().isValidChoice(choice));

        votingManager.vote(proposal, msg.sender, choice, votingPower().votingWeightOf(msg.sender));
    }

    /// @dev Approves a proposal.
    /// @param proposal ID of the proposal we want to approve
    function approve(uint proposal) external {
        require(votingRights().canApprove(msg.sender));
        proposalManager.approve(proposal);
    }

    // @todo move off chain
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

    /// @dev Tallies votes and submits count to proposal.
    /// @param id Id of the proposal to tally.
    function tally(uint id) external {
        require(votingPower().quorumReached(votingManager.quorum(id)));
        ProposalInterface(proposalManager.getProposal(id)).setWinningOption(winningOption(id));
    }


    function proposalManager() external view returns (ProposalManagerInterface) {
        return proposalManager;
    }

    function votingManager() external view returns (VotingManagerInterface) {
        return votingManager;
    }

    /// @dev Selects the winning option using the electoral system.
    /// @param id Id of the proposal
    /// @return id of the winning option
    function winningOption(uint id) public view returns (uint256) {
        return electoralSystem.winner(this, id);
    }

    function votingRights() public view returns (VotingRightsInterface) {
        return VotingRightsInterface(modules.getModule("rights"));
    }

    function votingPower() public view returns (VotingPowerInterface) {
        return VotingPowerInterface(modules.getModule("strategy"));
    }
}
