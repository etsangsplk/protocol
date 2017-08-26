pragma solidity ^0.4.11;

import "./Configuration.sol";
import "./ownership/ownable.sol";
import "./proposals/Proposal.sol";
import "./managers/ProposalManager.sol";
import "./managers/VotingManager.sol";
import "./voting/VotingStrategy.sol";
import "./voting/VotingRights.sol";
import { ProposalRegistryInterface as ProposalRegistry } from "./registries/ProposalRegistryInterface.sol";

contract Congress is ownable {

    event ProposalCreated(uint id, address addr, string name, address indexed creator);

    struct Modules {
        ProposalRegistry proposals;
        VotingRights rights;
        VotingStrategy strategy;
    }

    Modules modules;
    Configuration public configuration;
    ProposalManager public proposalManager;
    VotingManager public votingManager;

    mapping (uint => bool) executed;

    function Congress(
        Configuration _configuration,
        ProposalRegistry _proposals,
        ProposalManager _proposalManager,
        VotingRights _rights,
        VotingStrategy _strategy
    )
    {
        configuration = _configuration;
        modules = Modules({
            proposals: _proposals,
            rights: _rights,
            strategy: _strategy
        });

        proposalManager = _proposalManager;

        // @todo change to repository
        /*modules.rights.setVoting(modules.voting);*/
        /*modules.strategy.setVoting(modules.voting);*/
    }

    /// @dev Votes on a proposal.
    /// @param proposal ID of the proposal to vote on.
    /// @param choice Choice selected for vote.
    function vote(uint proposal, uint8 choice) external {
        require(modules.rights.isApproved(proposal));
        require(modules.rights.canVote(msg.sender));
        require(!votingManager.hasVoted(proposal, msg.sender));
        require(votingManager.isValidChoice(proposal, choice));
        votingManager.appendVote(proposal, msg.sender, choice);
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
}
