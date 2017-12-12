pragma solidity ^0.4.18;

import "./ElectoralSystemInterface.sol";
import "../Proposals/ProposalInterface.sol";

// @todo move into module repository
contract PluralitySystem is ElectoralSystemInterface {

    function winner(BallotInterface ballot) public view returns (uint) {
        uint candidate = 0;
        uint candidateVoteCount = 0;
        for (uint i = 0; i < ballot.optionsLength(); i++) {
            if (ballot.votes(i) > candidateVoteCount) {
                candidate = i;
                candidateVoteCount = ballot.votes(i);
            }
        }

        return i;
    }
}
