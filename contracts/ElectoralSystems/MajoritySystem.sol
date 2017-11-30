pragma solidity 0.4.18;

import "./PluralitySystem.sol";

// @todo move into module repository
contract MajoritySystem is PluralitySystem {

    function winner(BallotInterface ballot) public view returns (uint) {

        uint candidate = super.winner(ballot);
        uint quorum = ballot.quorum();
        uint votes = ballot.votes(candidate);
        uint percentage = ((votes * 10**4) / (quorum * 10**4)) * (10**4);

        require(percentage > 5000); // @todo check this

        return candidate;
    }
}
