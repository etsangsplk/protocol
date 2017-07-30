pragma solidity ^0.4.11;

import "./Configuration.sol";
import "./ownership/ownable.sol";
import "./proposals/Proposal.sol";
import "./executors/Executor.sol";
import { ProposalRepositoryInterface as ProposalRepository } from "./repositories/ProposalRepositoryInterface.sol";
import { ProposalFactoryInterface as ProposalFactory } from "./factories/ProposalFactoryInterface.sol";

contract Congress is ownable {

    struct Modules {
        ProposalRepository proposals;
    }

    Modules modules;
    Proposal[] public proposals;
    Configuration public configuration;

    mapping (uint => bool) executed;

    function Congress(Configuration _configuration, ProposalRepository proposals) {
        configuration = _configuration;
        modules = Modules({
            proposals: proposals
        });
    }

    function createProposal(string name, string methodSignature, bytes[] data) public {


        bytes4 sig = bytes4(sha3(methodSignature));

        assembly {
            let x = mload(0x40);
            mstore(x, sig);

            // @todo itterate data in assambly to add it to call
        }

        /*ProposalFactory factory;*/
        /*var (factory,) = modules.proposals.get(name);
        Proposal proposal = factory.delegatecall(data);
        proposals[proposals.length] = (proposal);*/
    }

    /*function executeProposal(uint _proposal) external {
        Proposal proposal = proposals[_proposal];

        assert(!executed[_proposal]);
        assert(proposal.deadline() < now);
        assert(proposal.getVoterQuorum() > configuration.get("minimumQuorum"));
        assert(proposal.didPass());

        Executor executor = executors[uint8(proposal.proposalType())];
        assert(executor.execute(proposal));

        executed[_proposal] = true;
    }*/
}
