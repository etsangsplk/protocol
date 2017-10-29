pragma solidity ^0.4.15;

import "../OrganizationInterface.sol";
import "../Voting/VotingPowerInterface.sol";
import "../Voting/VotingRightsInterface.sol";

contract OrganizationFactoryInterface {

    function createOrganization(VotingRightsInterface rights, VotingPowerInterface power) public returns (OrganizationInterface);

}
