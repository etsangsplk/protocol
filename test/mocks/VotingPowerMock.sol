pragma solidity 0.4.18;

import "../../contracts/Voting/VotingPowerInterface.sol";

contract VotingPowerMock is VotingPowerInterface {

    function quorumReached(uint) public view returns (bool) {
        return true;
    }

    function votingWeightOf(address) public view returns (uint) {
        return 1;
    }
}
