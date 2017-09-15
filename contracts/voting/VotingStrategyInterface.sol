pragma solidity ^0.4.11;

contract VotingStrategyInterface {

    function quorumReached(uint quorum) constant returns (bool);
    function votingWeightOf(address voter) constant returns (uint);

}
