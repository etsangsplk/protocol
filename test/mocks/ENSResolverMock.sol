pragma solidity ^0.4.19;

contract ENSResolverMock {

    mapping (bytes32 => address) resolvers;

    function setResolver(bytes32 node, address resolver) public {
        resolvers[node] = resolver;
    }

    function resolver(bytes32 node) public view returns (address) {
        return resolvers[node];
    }
}
