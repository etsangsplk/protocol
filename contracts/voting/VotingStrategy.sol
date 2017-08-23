pragma solidity ^0.4.11;

import "./VotingAware.sol";

contract VotingStrategy is VotingAware {

    function quorumReached(uint proposal) constant returns (bool);
    function winningChoice(uint proposal) constant returns (uint8); 
    function votingWeightOf(address voter) constant returns (uint);

}
