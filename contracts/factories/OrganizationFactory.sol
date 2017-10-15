pragma solidity ^0.4.15;

import "./OrganizationFactoryInterface.sol";
import "../Organization.sol";
import "../managers/VotingManager.sol";
import "../managers/ProposalManager.sol";
import "../Configuration.sol";

contract OrganizationFactory is OrganizationFactoryInterface {

    function createOrganization(VotingRightsInterface rights, VotingPowerInterface power) returns (OrganizationInterface) {

        ProposalManager proposalManager = new ProposalManager();
        VotingManager votingManager = new VotingManager();

        Organization organization = new Organization(
            new Configuration(),
            proposalManager,
            votingManager,
            rights,
            power
        );

        proposalManager.transferOwnership(address(organization));
        votingManager.transferOwnership(address(organization));

        return organization;
    }

}
