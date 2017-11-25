pragma solidity 0.4.18;

import "./PluralitySystem.sol";

// @todo move into module repository
contract MajoritySystem is PluralitySystem {

    function winner(OrganizationInterface organization, uint id) public view returns (uint) {

        VotingManagerInterface votingManager = organization.votingManager();

        uint candidate = super.winner(organization, id);
        uint quorum = votingManager.quorum(id);
        uint votes = votingManager.votes(id, candidate);
        uint percentage = ((votes * 10**4) / (quorum * 10**4)) * (10**4);

        require(percentage > 5000); // @todo check this

        return candidate;
    }
}
