pragma solidity ^0.4.15;

import "../../contracts/ENS/AddrResolver.sol";

contract AddrResolverMock is AddrResolver {

    mapping (bytes32 => address) records;

    function addRecord(bytes32 _node, address addr) {
        records[_node] = addr;
    }

    function addr(bytes32 _node) constant returns (address) {
        return records[_node];
    }
}
