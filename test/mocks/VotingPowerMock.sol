pragma solidity ^0.4.19;

import "../../contracts/Voting/VotingPowerInterface.sol";

contract VotingPowerMock is VotingPowerInterface {

    function maximumQuorum() public view returns (uint) {
        return 3;
    }

    function votingWeightOf(address, ProposalInterface) public view returns (uint) {
        return 1;
    }
}
