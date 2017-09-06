pragma solidity ^0.4.11;

import "../../contracts/voting/VotingRightsInterface.sol";

contract VotingRightsMock is VotingRightsInterface {

    function canVote(address voter) constant returns (bool) {
        return true;
    }

    function canPropose(address proposer) constant returns (bool) {
        return true;
    }

    function canApprove(address approver) constant returns (bool) {
        return true;
    }

    function requiresApproval(uint proposal) constant returns (bool) {
        return false;
    }

}
