pragma solidity ^0.4.11;

import "../voting/VotingStrategy.sol";

contract VotingStrategyMock is VotingStrategy {

    function quorumReached(uint proposal) constant returns (bool) {
        return true;
    }

    function proposalPassed(uint proposal) constant returns (bool)  {
        return true;
    }

}
