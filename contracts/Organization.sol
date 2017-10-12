pragma solidity ^0.4.15;

import "./Configuration.sol";
import "./OrganizationInterface.sol";
import "./ownership/ownable.sol";
import "./proposals/ProposalInterface.sol";
import "./voting/VotingPowerInterface.sol";
import "./voting/VotingRightsInterface.sol";
import "./electoralsystems/ElectoralSystemInterface.sol";
import "./managers/ProposalManagerInterface.sol";
import "./managers/VotingManagerInterface.sol";

contract Organization is OrganizationInterface, ownable {


    struct Modules {
        VotingRightsInterface rights;
        VotingPowerInterface power;
    }

    Modules modules;
    Configuration public configuration;
    ProposalManagerInterface public proposalManager;
    VotingManagerInterface public votingManager;
    ElectoralSystemInterface public electoralSystem;

    mapping (uint => bool) executed;

    event ProposalCreated(uint id, address proposal, address indexed creator);
    event ProposalExecuted(uint id);

    function Organization(
        Configuration _configuration,
        ProposalManagerInterface _proposalManager,
        VotingManagerInterface _votingManager,
        VotingRightsInterface _rights,
        VotingPowerInterface _power
    )
    {
        configuration = _configuration;
        modules = Modules({
            rights: _rights,
            power: _power
        });

        proposalManager = _proposalManager;
        votingManager = _votingManager;

        // @todo change to repository
        /*modules.rights.setVoting(modules.voting);*/
        /*modules.strategy.setVoting(modules.voting);*/
    }

    /// @dev Votes on a proposal.
    /// @param proposal ID of the proposal to vote on.
    /// @param choice Option selected for vote.
    function vote(uint proposal, uint choice) external {
        require(proposalManager.isApproved(proposal));
        require(modules.rights.canVote(msg.sender));
        require(ProposalInterface(proposalManager.getProposal(proposal)).ballot().getOptionsLength() > choice);

        votingManager.vote(proposal, msg.sender, choice, modules.power.votingWeightOf(msg.sender));
    }

    /// @dev Approves a proposal.
    /// @param proposal ID of the proposal we want to approve
    function approve(uint proposal) external {
        require(modules.rights.canApprove(msg.sender));
        proposalManager.approve(proposal);
    }

    // @todo move off chain
    /// @dev Creates a new proposal and stores it.
    /// @param proposalAddress Address of the new proposal.
    function propose(address proposalAddress) external {
        require(modules.rights.canPropose(msg.sender));

        // @todo we will need to hash the code to see if it matches the stored hash
        ProposalInterface proposal = ProposalInterface(proposal);

        uint id = proposalManager.add(msg.sender, proposalAddress);

        if (!modules.rights.requiresApproval(id)) {
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
        require(modules.power.quorumReached(votingManager.quorum(id)));
        ProposalInterface(proposalManager.getProposal(id)).setWinningOption(winningOption(id));
    }

    /// @dev Selects the winning option using the electoral system.
    /// @param id Id of the proposal
    /// @return id of the winning option
    function winningOption(uint id) public constant returns (uint256) {
        return electoralSystem.winner(this, id);
    }
}
