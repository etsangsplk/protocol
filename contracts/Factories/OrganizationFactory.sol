pragma solidity ^0.4.15;

import "./OrganizationFactoryInterface.sol";
import "../Organization.sol";
import "../Managers/VotingManager.sol";
import "../Managers/ProposalManager.sol";
import "../Configuration.sol";
import "../Registries/ModuleRegistry.sol";

contract OrganizationFactory is OrganizationFactoryInterface {

    // @todo these are proxies, not the real interface
    function createOrganization(VotingRightsInterface rights, VotingPowerInterface power) public returns (OrganizationInterface) {
        ProposalManager proposalManager = new ProposalManager();
        VotingManager votingManager = new VotingManager();

        ModuleRegistry modules = new ModuleRegistry();
        modules.addModule("rights", ProxyInterface(rights));
        modules.addModule("strategy", ProxyInterface(power));

        Organization organization = new Organization(new Configuration(), proposalManager, votingManager, modules);

        proposalManager.transferOwnership(address(organization));
        votingManager.transferOwnership(address(organization));

        return organization;
    }

}
