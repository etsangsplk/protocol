pragma solidity ^0.4.11;

import { VotingInterface as Voting } from "./VotingInterface.sol";

contract VotingAware {

    Voting public voting;

    function VotingAware(address _voting) {
        voting = Voting(_voting);
    }
}
