pragma solidity ^0.4.15;

import "./PluralitySystem.sol";

// @todo move into module repository
contract MajoritySystem is PluralitySystem {

    function winner(OrganizationInterface organization, uint256 id) constant returns (uint256) {

        VotingManagerInterface votingManager = organization.votingManager();

        uint256 candidate = super.winner(organization, id);
        uint256 quorum = votingManager.quorum(id);
        uint256 votes = votingManager.votes(id, candidate);
        uint256 percentage = ((votes * 10**4) / (quorum * 10**4)) * (10**4);

        require(percentage > 5000); // @todo check this

        return candidate;
    }
}
