pragma solidity ^0.4.11;

contract VotingStrategyInterface {

    function quorumReached(uint proposal) constant returns (bool);
    function winningChoice(uint proposal) constant returns (uint8); 
    function votingWeightOf(address voter) constant returns (uint);

}
