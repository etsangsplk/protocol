pragma solidity ^0.4.15;

import "../Organization.sol";
import "../Configuration.sol";
import "../managers/ProposalManager.sol";
import "../managers/VotingManager.sol";
import "../registries/ModuleRegistry.sol";
import "../factories/OrganizationFactoryInterface.sol";

contract Version {

    uint public lastId;

    OrganizationFactoryInterface public organizationFactory;

    mapping (uint => address) organizations;

    event OrganizationCreated(uint id, address organization);


    function Version(OrganizationFactoryInterface _organizationFactory) {
        organizationFactory = _organizationFactory;
    }

    function createOrganization(
        bytes32 votingRightsHash,
        VotingRightsInterface rights,
        bytes32 votingPowerHash,
        VotingPowerInterface power
    ) external {

        OrganizationInterface org = organizationFactory.createOrganization(
            votingRightsHash,
            rights,
            votingPowerHash,
            power
        );

        uint id = nextId();
        organizations[id] = org;
        OrganizationCreated(id, org);
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
