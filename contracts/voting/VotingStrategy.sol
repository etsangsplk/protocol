pragma solidity ^0.4.11;

contract VotingStrategy {

    function canVote(address voter, uint propsal) constant returns (bool);
    function quorumReached(uint proposal) constant returns (bool);
    function proposalPassed(uint proposal) constant returns (bool);

}
