pragma solidity ^0.4.15;

import "../OrganizationInterface.sol";

// @todo this is ugly, lets see if we can do it with libraries later
contract ElectoralSystemInterface {

    function winner(OrganizationInterface organization, uint256 id) constant returns (uint256);

}
