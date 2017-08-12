pragma solidity ^0.4.11;

import "../../contracts/factories/ProposalFactoryInterface.sol";
import "../../contracts/proposals/Proposal.sol";

contract ProposalFactoryMock is ProposalFactoryInterface {

    function create(uint test) returns (Proposal) {
        uint8[] memory choices;
        choices.push(1);
        choices.push(2);
        return new MockProposal(test, choices);
    }

}

contract MockProposal is Proposal {

    uint public test;

    function MockProposal(uint _test, uint8[] _choices) Proposal(_choices) {
        test = _test;
    }
}
