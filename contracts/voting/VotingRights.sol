pragma solidity ^0.4.11;

contract VotingRights {

    function canVote(address voter) constant returns (bool);
    function canPropose(address proposer) constant returns (bool);
    function canApprove(address approver) constant returns (bool);
    function requiresApproval(/* will require proposal id */) constant returns (bool);

}
