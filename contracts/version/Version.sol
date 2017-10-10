pragma solidity ^0.4.15;

import "../Organization.sol";
import "../Configuration.sol";
import "../managers/ProposalManager.sol";
import "../managers/VotingManager.sol";

contract Version {

    uint public lastId;

    mapping (uint => address) organizations;

    event OrganizationCreated(uint id, address organization);

    function createOrganization(VotingRightsInterface rights, VotingPowerInterface power) external returns (uint)
    {
        uint id = nextId();

        ProposalManager manager = new ProposalManager();
        VotingManager votingManager = new VotingManager();

        Organization organization = new Organization(
            new Configuration(),
            manager,
            votingManager,
            rights,
            power
        );

        manager.transferOwnership(address(organization));
        votingManager.transferOwnership(address(organization));

        OrganizationCreated(id, organization);
        organizations[id] = organization;
        return id;
    }

    function upgradeOrganization(uint id) external {
        OrganizationInterface organization = OrganizationInterface(organizations[id]);

//        address configuration = organization.configuration();
//        address proposalManager = organization.proposalManager();
//        address votingManager = organization.votingManager();

        // @todo get voting strategies etc
        // @todo suicide org
    }

    function destroyOrganization(uint id) external {
        // @todo trigger selfdestruct
        delete organizations[id];
    }

    function getOrganization(uint id) external returns (address) {
        return organizations[id];
    }

    function nextId() private returns (uint) {
        lastId++;
        return lastId;
    }
}
