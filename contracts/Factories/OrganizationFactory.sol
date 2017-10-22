pragma solidity ^0.4.15;

import "./OrganizationFactoryInterface.sol";
import "../Organization.sol";
import "../Managers/VotingManager.sol";
import "../Managers/ProposalManager.sol";
import "../Configuration.sol";
import "../Registries/ModuleRegistry.sol";

contract OrganizationFactory is OrganizationFactoryInterface {

    function createOrganization(
        bytes32 votingRightsHash,
        VotingRightsInterface rights,
        bytes32 votingPowerHash,
        VotingPowerInterface power
    )
    public returns (OrganizationInterface)
    {
        ProposalManager proposalManager = new ProposalManager();
        VotingManager votingManager = new VotingManager();


        ModuleRegistry modules = new ModuleRegistry();
        modules.addModule("rights", rights, votingRightsHash);
        modules.addModule("strategy", power, votingPowerHash);

        Organization organization = new Organization(
            new Configuration(),
            proposalManager,
            votingManager,
            modules
        );

        proposalManager.transferOwnership(address(organization));
        votingManager.transferOwnership(address(organization));

        return organization;
    }

}
