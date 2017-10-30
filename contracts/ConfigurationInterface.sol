pragma solidity ^0.4.15;

contract ConfigurationInterface {

    function set(bytes32 key, uint value);
    function get(bytes32 key) returns (uint);
}
