pragma solidity ^0.4.19;

import "../OrganizationInterface.sol";
import "../Voting/VotingPowerInterface.sol";
import "../Voting/VotingRightsInterface.sol";

interface OrganizationFactoryInterface {

    function createOrganization(VotingRightsInterface rights, VotingPowerInterface power)
        external
        returns (OrganizationInterface);

}
