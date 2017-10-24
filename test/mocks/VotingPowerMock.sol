pragma solidity ^0.4.15;

import "../../contracts/Voting/VotingPowerInterface.sol";

contract VotingPowerMock is VotingPowerInterface {

    function quorumReached(uint) constant returns (bool) {
        return true;
    }

    function votingWeightOf(address) constant returns (uint) {
        return 1;
    }
}
