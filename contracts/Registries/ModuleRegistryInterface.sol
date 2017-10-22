pragma solidity ^0.4.15;

contract ModuleRegistryInterface {

    function addModule(bytes32 name, address module, bytes32 hash) external;
    function getModule(bytes32 name) external constant returns (address);
    function getHash(bytes32 name) external constant returns (bytes32);

    // @todo remove module
    // @todo update module
    // @todo figure out permission handling.
}
