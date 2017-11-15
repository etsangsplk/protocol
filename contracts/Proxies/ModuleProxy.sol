pragma solidity 0.4.18;

import "./Proxy.sol";
import "../ENS/AddrResolver.sol";
import "../ENS/ENSInterface.sol";
import "../Ownership/Ownable.sol";

contract ModuleProxy is Proxy, Ownable {

    bytes32 public node;
    ENSInterface public ens;

    function ModuleProxy(ENSInterface _ens, bytes32 _node) public {
        node = _node;
        ens = _ens;
    }

    function() public payable {
        forward(AddrResolver(ens.resolver(node)).addr(node), msg.data);
    }

    function updateTarget(bytes32 newNode) external onlyOwner {
        node = newNode;
    }
}
