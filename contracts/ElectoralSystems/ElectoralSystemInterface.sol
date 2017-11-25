pragma solidity 0.4.18;

import "../OrganizationInterface.sol";

// @todo this is ugly, lets see if we can do it with libraries later
interface ElectoralSystemInterface {

    function winner(OrganizationInterface organization, uint id) public view returns (uint);

}
