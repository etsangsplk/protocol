pragma solidity ^0.4.20;

import "./PluralitySystem.sol";

// @todo move into module repository
contract MajoritySystem is PluralitySystem {

    function winner(BallotInterface ballot) public view returns (uint) {

        uint candidate = super.winner(ballot);

        require(isMajority(ballot, candidate));

        return candidate;
    }

    function hasWinner(BallotInterface ballot) public view returns (bool) {
        return isMajority(ballot, super.winner(ballot));
    }

    function isMajority(BallotInterface ballot, uint candidate) internal view returns (bool) {
        uint quorum = ballot.quorum();
        uint votes = ballot.votes(candidate);
        uint percentage = ((votes * 10**4) / (quorum * 10**4)) * (10**4);

        return percentage > 5000; // @todo validate this
    }

}
