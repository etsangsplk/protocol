pragma solidity ^0.4.11;

contract VotingStrategy {

    function canPropose(address proposer) constant returns (bool);
    function canVote(address voter, uint propsal) constant returns (bool);
    function quorumReached(uint proposal) constant returns (bool);
    function proposalPassed(uint proposal) constant returns (bool);

}
