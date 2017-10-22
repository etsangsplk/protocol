pragma solidity ^0.4.15;

import "../../contracts/Voting/VotingPowerInterface.sol";

contract VotingPowerMock is VotingPowerInterface {

    function quorumReached(uint quorum) constant returns (bool) {
        return true;
    }

    function votingWeightOf(address voter) constant returns (uint) {
        return 1;
    }
}
