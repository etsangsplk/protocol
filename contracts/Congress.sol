pragma solidity ^0.4.11;

import "./Configuration.sol";
import "./ownership/ownable.sol";
import "./proposals/Proposal.sol";
import "./voting/VotingStrategy.sol";
import "./executors/Executor.sol";
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
    Proposal[] public proposals;
    Configuration public configuration;

    mapping (uint => bool) executed;

    function Congress(
        Configuration _configuration,
        ProposalRegistry _proposals,
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
    }

    /// @dev Votes on a proposal.
    /// @param proposal ID of the proposal to vote on.
    /// @param choice Choice selected for vote.
    function vote(uint proposal, uint8 choice) {
        require(modules.rights.canVote(msg.sender));
        proposals[proposal].vote(choice);
    }

    /// @dev Creates a new proposal and stores it.
    /// @param name Name of the desired proposal type.
    /// @param arguments Byte encoded constructor arguments
    function propose(string name, bytes arguments) external {
        require(modules.rights.canPropose(msg.sender));

        // @todo we will need to hash the code to see if it matches the stored hash
        //var (factory,) = modules.proposals.get(name);

        uint id = proposals.length;
        Proposal proposal = Proposal(createProposal(code, arguments));
        proposals.push(proposal);

        ProposalCreated(id, address(proposal), name, msg.sender);
    }

    function createProposal(bytes code, bytes32[] arguments) internal returns (address) {

        // @todo code + arguments need be merged

        address retval;
        assembly {
            retval := create(0, add(code,0x20), mload(code))
            jumpi(invalidJumpLabel, iszero(extcodesize(retval)))
        }

        return retval;
    }
}
