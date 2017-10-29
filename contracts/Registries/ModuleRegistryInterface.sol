pragma solidity ^0.4.15;

import "../Proxies/ProxyInterface.sol";

contract ModuleRegistryInterface {

    function addModule(bytes32 name, ProxyInterface module) external;
    function getModule(bytes32 name) external constant returns (address);

    // @todo remove module
    // @todo update module
    // @todo figure out permission handling.
}
