pragma solidity ^0.4.18;

interface ConfigurationInterface {

    function set(bytes32 key, uint value) external;
    function get(bytes32 key) external view returns (uint);
}
