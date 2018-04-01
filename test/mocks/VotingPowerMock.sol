pragma solidity ^0.4.20;

import "../../contracts/Voting/VotingPowerInterface.sol";

contract VotingPowerMock is VotingPowerInterface {

    function maximumQuorum(ProposalInterface) public view returns (uint) {
        return 3;
    }

    function votingWeightOf(address, ProposalInterface) public view returns (uint) {
        return 1;
    }
}
