pragma solidity ^0.4.20;

import "./ElectoralSystemInterface.sol";
import "../Proposals/ProposalInterface.sol";

// @todo move into module repository
contract PluralitySystem is ElectoralSystemInterface {

    function winner(BallotInterface ballot) public view returns (uint) {
        uint candidate = 0;
        uint candidateVoteCount = 0;

        uint length = ballot.optionsLength();
        for (uint i = 0; i < length; i++) {
            if (ballot.votes(i) > candidateVoteCount) {
                candidate = i;
                candidateVoteCount = ballot.votes(i);
            }
        }

        return i;
    }

    function topCandidates(BallotInterface ballot) public view returns (uint[2]) {
        uint[2] memory candidates;
        uint[2] memory candidateVoteCounts;

        uint length = ballot.optionsLength();
        for (uint i = 0; i < length; i++) {
            uint votes = ballot.votes(i);

            if (votes > candidateVoteCounts[0]) {
                candidates[1] = candidates[0];
                candidates[0] = i;
                candidateVoteCounts[1] = candidateVoteCounts[0];
                candidateVoteCounts[0] = votes;
                continue;
            }

            if (votes > candidateVoteCounts[1] || votes == candidateVoteCounts[0]) {
                candidates[1] = i;
                candidateVoteCounts[1] = votes;
            }
        }

        return candidates;
    }

    function hasWinner(BallotInterface) public view returns (bool) {
        return true; // @todo maybe calc that there are none with the same vote count
    }
}
