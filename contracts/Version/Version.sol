pragma solidity ^0.4.19;

import "../Organization.sol";
import "../Configuration.sol";
import "../Managers/ProposalManager.sol";
import "../Registries/ModuleRegistry.sol";
import "../Factories/OrganizationFactoryInterface.sol";

contract Version {

    uint public lastId;

    OrganizationFactoryInterface public organizationFactory;

    mapping (uint => address) organizations;

    event OrganizationCreated(uint id, address organization);

    function Version(OrganizationFactoryInterface _organizationFactory) public {
        organizationFactory = _organizationFactory;
    }

    function createOrganization(VotingRightsInterface rights, VotingPowerInterface power) external {

        OrganizationInterface org = organizationFactory.createOrganization(rights, power);

        uint id = nextId();
        organizations[id] = org;
        OrganizationCreated(id, org);
    }

    function destroyOrganization(uint id) external {
        // @todo trigger selfdestruct
        delete organizations[id];
    }

    function nextId() private returns (uint) {
        lastId++;
        return lastId;
    }
}
