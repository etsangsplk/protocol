pragma solidity ^0.4.11;

import "../../contracts/voting/VotingStrategyInterface.sol";

contract VotingStrategyMock is VotingStrategyInterface {

    function quorumReached(uint proposal) constant returns (bool) {
        return true;
    }

    function winningChoice(uint proposal) constant returns (uint8)  {
        return 0;
    }

    function votingWeightOf(address voter) constant returns (uint) {
        return 1;
    }
}
