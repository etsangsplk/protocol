pragma solidity 0.4.18;

interface VotingRightsInterface {

    function canVote(address voter) public view returns (bool);
    function canPropose(address proposer) public view returns (bool);
    function canApprove(address approver) public view returns (bool);
    function requiresApproval(uint proposal) public view returns (bool);

}
