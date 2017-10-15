pragma solidity ^0.4.15;

import "../OrganizationInterface.sol";
import "../voting/VotingPowerInterface.sol";
import "../voting/VotingRightsInterface.sol";

contract OrganizationFactoryInterface {

    function createOrganization(VotingRightsInterface rights, VotingPowerInterface power) returns (OrganizationInterface);

}
