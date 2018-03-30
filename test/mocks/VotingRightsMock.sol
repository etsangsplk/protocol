pragma solidity ^0.4.20;

import "../../contracts/Voting/VotingRightsInterface.sol";

contract VotingRightsMock is VotingRightsInterface {

    mapping (address => bool) voters;

    function addVoter(address voter) public {
        voters[voter] = true;
    }

    function canVote(address voter, ProposalInterface) public view returns (bool) {
        return voters[voter];
    }

    function canPropose(address) public view returns (bool) {
        return true;
    }

    function canApprove(address) public view returns (bool) {
        return true;
    }

    function requiresApproval(uint) public view returns (bool) {
        return true;
    }

}
