pragma solidity ^0.4.15;

import "./ElectoralSystemLibraryInterface.sol";
import "../proposals/ProposalInterface.sol";
import "../managers/ProposalManagerInterface.sol";
import "../managers/VotingManagerInterface.sol";

contract PluralitySystemLibrary is ElectoralSystemLibraryInterface {

    ProposalManagerInterface public proposalManager;
    VotingManagerInterface public votingManager;

    function winningOption(uint256 id) constant returns (uint256) {
        BallotInterface ballot = ProposalInterface(proposalManager.getProposal(id)).ballot();

        uint winner = 0;
        for (uint i = 1; i < ballot.getOptionsLength(); i++) {
            if (votingManager.votes(id, i) > votingManager.votes(id, winner)) {
                winner = i;
            }
        }

        return i;
    }
}
