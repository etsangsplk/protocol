pragma solidity ^0.4.15;

import "../OrganizationInterface.sol";
import "../Voting/VotingPowerInterface.sol";
import "../Voting/VotingRightsInterface.sol";

contract OrganizationFactoryInterface {

    function createOrganization(
        bytes32 votingRightsHash,
        VotingRightsInterface rights,
        bytes32 votingPowerHash,
        VotingPowerInterface power
    ) public returns (OrganizationInterface);

}
