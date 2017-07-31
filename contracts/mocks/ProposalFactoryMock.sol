pragma solidity ^0.4.11;

import "../factories/ProposalFactoryInterface.sol";
import "../proposals/Proposal.sol";

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

    function voteRangeEnabled() returns (bool) {
        false;
    }

    function isValidVoteRange(uint8 _range) returns (bool) {
        false;
    }
}
