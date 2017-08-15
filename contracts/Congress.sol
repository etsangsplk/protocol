pragma solidity ^0.4.11;

import "./Configuration.sol";
import "./ownership/ownable.sol";
import "./proposals/Proposal.sol";
import "./voting/VotingStrategy.sol";
import "./executors/Executor.sol";
import "./voting/VotingRights.sol";
import { ProposalRegistryInterface as ProposalRegistry } from "./registries/ProposalRegistryInterface.sol";

contract Congress is ownable {

    event ProposalCreated(uint id, string name, address indexed creator);

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

    function vote(uint proposal, bool inFavour) {
        require(modules.rights.canVote(msg.sender));
        proposals[proposal].vote(inFavour);
    }

    /*function propose(string name, bytes payload) external {
        var (factory,) = modules.proposals.get(name);

        uint id = proposals.length;
        Proposal proposal = createProposal(factory, payload);
        proposals.push(proposal);

        ProposalCreated(id, name, msg.sender);
    }*/

    /*function createProposal(ProposalFactory factory, bytes payload) internal returns (Proposal) {
        Proposal proposal;
        uint len = payload.length;
        uint r = 0;

        assembly {
            r := call(sub(gas, 10000), factory, 0, add(payload, 0x20), mload(payload), 0, len)
        }

        require(r == 1);

        assembly {
            proposal := mload(32)
        }
    }*/

    function createProposal(bytes code, bytes32[] arguments) internal returns (address) {
        address retval;
        assembly {
            retval := create(0,add(code,0x20), mload(code))
            jumpi(invalidJumpLabel,iszero(extcodesize(addr)))
        }

        return retval;
    }
}
