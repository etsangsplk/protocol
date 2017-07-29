pragma solidity ^0.4.11;

import "./Configuration.sol";
import "./ownership/ownable.sol";
import "./proposals/Proposal.sol";
import "./executors/Executor.sol";
import { ProposalRepositoryInterface as ProposalRepository } from "./repositories/ProposalRepositoryInterface.sol";
import { ProposalFactoryInterface as ProposalFactory } from "./factories/ProposalFactoryInterface.sol";

contract Congress is ownable {

    Proposal[] public proposals;
    Configuration public configuration;
    ProposalRepository public proposalRepository;

    mapping (uint => bool) executed;

    function Congress(Configuration _configuration) {
        configuration = _configuration;
    }

    function createProposal(string name, bytes data) public {
        /*ProposalFactory factory;*/
        var (factory,) = proposalRepository.get(name);
        Proposal proposal = factory.delegatecall(data);
        proposals[proposals.length] = (proposal);
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
