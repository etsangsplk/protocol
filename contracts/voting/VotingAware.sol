pragma solidity ^0.4.11;

import "./VotingInterface.sol";

contract VotingAware {

    VotingInterface public voting;

    modifier onlyWhenVotingNotSet() { require(address(voting) == 0); _; }

    function setVoting(address _voting) onlyWhenVotingNotSet {
        voting = VotingInterface(_voting);
    }
}
