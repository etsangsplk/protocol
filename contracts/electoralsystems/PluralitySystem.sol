pragma solidity ^0.4.15;

import "./ElectoralSystemInterface.sol";
import "../proposals/ProposalInterface.sol";

// @todo move into module repository
contract PluralitySystem is ElectoralSystemInterface {

    function winner(OrganizationInterface organization, uint256 id) constant returns (uint256) {
        BallotInterface ballot = ProposalInterface(organization.proposalManager().getProposal(id)).ballot();
        VotingManagerInterface votingManager = organization.votingManager();

        uint candidate = 0;
        for (uint i = 1; i < ballot.getOptionsLength(); i++) {
            if (votingManager.votes(id, i) > votingManager.votes(id, candidate)) {
                candidate = i;
            }
        }

        return i;
    }
}
