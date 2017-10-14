pragma solidity ^0.4.15;

contract ConfigurationInterface {

    function set(bytes32 _key, uint _value);
    function get(bytes32 _key) returns (uint);
}
