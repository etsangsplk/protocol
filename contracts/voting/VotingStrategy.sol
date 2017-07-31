pragma solidity ^0.4.11;

contract VotingStrategy {

    function quorumReached(uint proposal) constant returns (bool);
    function proposalPassed(uint proposal) constant returns (bool);

}
