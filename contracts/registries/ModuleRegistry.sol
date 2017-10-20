pragma solidity ^0.4.15;

import "./ModuleRegistryInterface.sol";

contract ModuleRegistry is ModuleRegistryInterface {

    struct Module {
        address module;
        bytes32 hash;
    }

    mapping (bytes32 => Module) public modules;

    /// @dev Adds a module to module list
    /// @param name Name of the module
    /// @param module Address of the module
    /// @param hash Hash to access module contract information
    function addModule(bytes32 name, address module, bytes32 hash) external {
        modules[name] = Module({
            module: module,
            hash: hash
        });
    }

    /// @dev Returns address for module
    /// @param name Name of the module
    /// @return Address of the module
    function getModule(bytes32 name) external constant returns (address) {
        return modules[name].module;
    }

    /// @dev Returns hash for module
    /// @param name Name of the module
    /// @return Hash to access module contract information
    function getHash(bytes32 name) external constant returns (bytes32) {
        return modules[name].hash;
    }
}
