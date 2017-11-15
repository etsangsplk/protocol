pragma solidity 0.4.18;

import "../../contracts/ENS/AddrResolver.sol";

contract AddrResolverMock is AddrResolver {

    mapping (bytes32 => address) records;

    function addRecord(bytes32 node, address addr) public {
        records[node] = addr;
    }

    function addr(bytes32 node) public view returns (address) {
        return records[node];
    }
}
