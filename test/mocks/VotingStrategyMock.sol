pragma solidity ^0.4.15;

import "../../contracts/voting/VotingStrategyInterface.sol";

contract VotingStrategyMock is VotingStrategyInterface {

    function quorumReached(uint quorum) constant returns (bool) {
        return true;
    }

    function winningChoice(uint proposal) constant returns (uint8)  {
        return 0;
    }

    function votingWeightOf(address voter) constant returns (uint) {
        return 1;
    }
}
