pragma solidity ^0.4.11;

import "./Configuration.sol";
import "./ownership/ownable.sol";
import "./proposals/Proposal.sol";
import "./voting/VotingStrategyInterface.sol";
import "./voting/VotingRightsInterface.sol";
import "./registries/ProposalRegistryInterface.sol";
import "./managers/ProposalManagerInterface.sol";
import "./managers/VotingManagerInterface.sol";

contract Congress is ownable {

    struct Modules {
        ProposalRegistryInterface proposals;
        VotingRightsInterface rights;
        VotingStrategyInterface strategy;
    }

    Modules modules;
    Configuration public configuration;
    ProposalManagerInterface public proposalManager;
    VotingManagerInterface public votingManager;

    mapping (uint => bool) executed;

    event ProposalCreated(uint id, address addr, string name, address indexed creator);
    event ProposalExecuted(uint id);

    function Congress(
        Configuration _configuration,
        ProposalRegistryInterface _proposals,
        ProposalManagerInterface _proposalManager,
        VotingManagerInterface _votingManager,
        VotingRightsInterface _rights,
        VotingStrategyInterface _strategy
    )
    {
        configuration = _configuration;
        modules = Modules({
            proposals: _proposals,
            rights: _rights,
            strategy: _strategy
        });

        proposalManager = _proposalManager;
        votingManager = _votingManager;

        // @todo change to repository
        /*modules.rights.setVoting(modules.voting);*/
        /*modules.strategy.setVoting(modules.voting);*/
    }

    /// @dev Votes on a proposal.
    /// @param proposal ID of the proposal to vote on.
    /// @param choice Choice selected for vote.
    function vote(uint proposal, uint8 choice) external {
        require(proposalManager.isApproved(proposal));
        require(modules.rights.canVote(msg.sender));
        votingManager.vote(proposal, msg.sender, choice);
    }

    /// @dev Approves a proposal.
    /// @param proposal ID of the proposal we want to approve
    function approve(uint proposal) external {
        require(modules.rights.canApprove(msg.sender));
        proposalManager.approve(proposal);
    }

    /// @dev Creates a new proposal and stores it.
    /// @param name Name of the desired proposal type.
    /// @param arguments Byte encoded constructor arguments
    function propose(string name, bytes arguments) external {
        require(modules.rights.canPropose(msg.sender));

        // @todo we will need to hash the code to see if it matches the stored hash
        Proposal proposal = Proposal(modules.proposals.create(name, arguments));

        uint id = proposalManager.add(msg.sender, proposal);

        if (!modules.rights.requiresApproval(id)) {
            proposalManager.approve(id);
        }

        ProposalCreated(id, address(proposal), name, msg.sender);
    }

    /// @dev Executes a proposal if it has passed.
    /// @param id ID of the proposal to execute.
    function execute(uint id) external {
        Proposal proposal = Proposal(proposalManager.getProposal(id));

        assert(!proposal.wasExecuted());
        assert(modules.strategy.quorumReached(id));

        uint8 winner = modules.strategy.winningChoice(id);
        require(winner != 0); // 0 is defaulted to false

        proposal.execute(winner);
        ProposalExecuted(id);
    }
}
