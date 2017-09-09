pragma solidity ^0.4.11;

contract VotingRightsInterface {

    function canVote(address voter) constant returns (bool);
    function canPropose(address proposer) constant returns (bool);
    function canApprove(address approver) constant returns (bool);
    function requiresApproval(uint proposal) constant returns (bool);

}