pragma solidity ^0.4.11;

import "../Organization.sol";
import "../Configuration.sol";
import "../managers/ProposalManager.sol";
import "../managers/VotingManager.sol";
import "../registries/ProposalRegistry.sol";

contract Version {

    uint public lastId;

    mapping (uint => address) organizations;

    event OrganizationCreated(uint id, address organization);

    function createOrganization(
        VotingRightsInterface votingRights,
        VotingStrategyInterface votingStrategy
    ) external returns (uint) {

        uint id = nextId();

        ProposalManager manager = new ProposalManager();
        VotingManager votingManager = new VotingManager();

        Organization organization = new Organization(
            new Configuration(),
            new ProposalRegistry(),
            manager,
            votingManager,
            votingRights,
            votingStrategy
        );

        manager.transferOwnership(address(organization));
        votingManager.transferOwnership(address(organization));

        OrganizationCreated(id, organization);
        organizations[id] = organization;
        return id;
    }

    function destroyOrganization(uint id) external {
        // @todo trigger selfdestruct
        delete organizations[id];
    }

    function getOrganization(uint id) external returns (address) {
        return organizations[id];
    }

    function nextId() private returns (uint) {
        lastId++; return lastId;
    }
}
