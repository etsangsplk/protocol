pragma solidity 0.4.18;

import "./Proxy.sol";
import "../ENS/AddrResolver.sol";
import "../Ownership/Ownable.sol";

contract ModuleProxy is Proxy, Ownable {

    bytes32 public node;
    AddrResolver public resolver;

    function ModuleProxy(AddrResolver _resolver, bytes32 _node) public {
        node = _node;
        resolver = _resolver;
    }

    function() public payable {
        forward(resolver.addr(node), msg.data);
    }

    function updateTarget(bytes32 newNode) external onlyOwner {
        node = newNode;
    }
}
