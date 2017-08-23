pragma solidity ^0.4.11;

import "./VotingAware.sol";

contract VotingStrategy is VotingAware {

    function quorumReached(uint proposal) constant returns (bool);
    function proposalPassed(uint proposal) constant returns (bool);
    function votingWeightOf(address voter) constant returns (uint);

}
