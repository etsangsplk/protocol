pragma solidity ^0.4.20;

interface AddrResolver {
    function addr(bytes32 node) public view returns (address);
}
