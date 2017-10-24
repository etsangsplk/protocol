pragma solidity ^0.4.15;

import "../../contracts/Voting/VotingRightsInterface.sol";

contract VotingRightsMock is VotingRightsInterface {

    mapping (address => bool) voters;

    function addVoter(address voter) public {
        voters[voter] = true;
    }

    function canVote(address voter) constant returns (bool) {
        return voters[voter];
    }

    function canPropose(address) constant returns (bool) {
        return true;
    }

    function canApprove(address) constant returns (bool) {
        return true;
    }

    function requiresApproval(uint) constant returns (bool) {
        return true;
    }

}
