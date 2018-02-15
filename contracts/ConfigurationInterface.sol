pragma solidity ^0.4.19;

interface ConfigurationInterface {

    function set(bytes32 key, uint value) external;
    function get(bytes32 key) external view returns (uint);
}
