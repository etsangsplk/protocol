pragma solidity ^0.4.11;

import { VotingInterface as Voting } from "./VotingInterface.sol";

contract VotingAware {

    Voting public voting;

    modifier onlyWhenVotingNotSet() { require(address(voting) == 0); _; }

    function setVoting(address _voting) onlyWhenVotingNotSet {
        voting = Voting(_voting);
    }
}
