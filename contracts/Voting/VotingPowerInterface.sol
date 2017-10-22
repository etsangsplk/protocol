pragma solidity ^0.4.15;

contract VotingPowerInterface {

    function quorumReached(uint quorum) constant returns (bool);
    function votingWeightOf(address voter) constant returns (uint);

}
