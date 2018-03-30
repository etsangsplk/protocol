pragma solidity ^0.4.20;

import "../Proxies/ProxyInterface.sol";

interface ModuleRegistryInterface {

    function addModule(bytes32 name, ProxyInterface module) external;
    function getModule(bytes32 name) external view returns (address);

    // @todo remove module
    // @todo update module
    // @todo figure out permission handling.
}
