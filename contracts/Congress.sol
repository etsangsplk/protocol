pragma solidity ^0.4.11;

import "./Configuration.sol";
import "./ownership/ownable.sol";
import "./proposals/Proposal.sol";
import "./executors/Executor.sol";
import { ProposalRepositoryInterface as ProposalRepository } from "./repositories/ProposalRepositoryInterface.sol";
import { ProposalFactoryInterface as ProposalFactory } from "./factories/ProposalFactoryInterface.sol";

contract Congress is ownable {

    event ProposalCreated(uint id, string name, address indexed creator);

    struct Modules {
        ProposalRepository proposals;
    }

    Modules modules;
    Proposal[] public proposals;
    Configuration public configuration;

    mapping (uint => bool) executed;

    function Congress(Configuration _configuration, ProposalRepository _proposals) {
        configuration = _configuration;
        modules = Modules({
            proposals: _proposals
        });
    }

    function propose(string name, bytes payload) public {
        var (factory,) = modules.proposals.get(name);

        uint id = proposals.length;
        Proposal proposal = createProposal(factory, payload);
        proposals.push(proposal);
        ProposalCreated(id, name, msg.sender);
    }

    function createProposal(ProposalFactory factory, bytes payload) internal returns (Proposal) {
        Proposal proposal;
        uint32 len =  24 * 32;
        uint r = 0;

        assembly {
            r := call(sub(gas, 10000), factory, 0, add(payload, 0x20), mload(payload), 0, len)
        }

        require(r == 1);

        assembly {
            proposal := mload(32)
        }
    }
}
