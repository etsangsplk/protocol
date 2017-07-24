pragma solidity ^0.4.11;

import "../Configuration.sol";
import "../ownership/ownable.sol";
import "./proposals/Proposal.sol";
import "./executors/Executor.sol";

contract Congress is ownable {

    Proposal[] public proposals;
    Configuration public configuration;

    mapping (uint8 => Executor) executors;
    mapping (uint => bool) executed;

    function Congress(Configuration _configuration) {
        configuration = _configuration;
    }

    function setExecutor(Executor _executor) onlyOwner {
        require(_executor.isOwner(this));
        executors[uint8(_executor.proposalType())] = _executor;
    }

    function executeProposal(uint _proposal) external {
        Proposal proposal = proposals[_proposal];

        assert(!executed[_proposal]);
        assert(proposal.deadline() < now);
        assert(proposal.getVoterQuorum() > configuration.get("minimumQuorum"));
        assert(proposal.didPass());

        Executor executor = executors[uint8(proposal.proposalType())];
        assert(executor.execute(proposal));

        executed[_proposal] = true;
    }
}