pragma solidity ^0.4.11;

import "../../contracts/factories/ProposalFactoryInterface.sol";
import "../../contracts/proposals/Proposal.sol";

contract ProposalFactoryMock is ProposalFactoryInterface {

    function create(uint test) returns (Proposal) {
        return new MockProposal(test);
    }

}

contract MockProposal is Proposal {

    uint public test;

    function MockProposal(uint _test) {
        test = _test;
    }
}
