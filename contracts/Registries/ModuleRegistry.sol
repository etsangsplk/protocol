pragma solidity ^0.4.19;

import "./ModuleRegistryInterface.sol";

// @todo ownership
contract ModuleRegistry is ModuleRegistryInterface {

    mapping (bytes32 => ProxyInterface) public modules;

    /// @dev Adds a module to module list
    /// @param name Name of the module
    /// @param module Address of the module proxy
    function addModule(bytes32 name, ProxyInterface module) external {
        modules[name] = module;
    }

    /// @dev Returns address for module
    /// @param name Name of the module
    /// @return Address of the module
    function getModule(bytes32 name) external view returns (address) {
        return modules[name];
    }
}
