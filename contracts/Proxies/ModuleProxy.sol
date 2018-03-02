pragma solidity ^0.4.19;

import "./Proxy.sol";
import "../ENS/AddrResolver.sol";
import "../ENS/ENSInterface.sol";
import "../Ownership/Ownable.sol";

// UNSAFE AND SHOULD NOT BE USED. ENS NODE COJLD BE CHANGED, LEAVING US WITH PARITY TYPE BUG POTENTIALLY.
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
