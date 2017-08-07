pragma solidity ^0.4.11;

import "../executors/Executor.sol";

contract ProposalRegistryInterface {

    event ProposalAdded(string name);
    event ProposalRemoved(string name);

    function add(string name, Executor executor, bytes abi) public;
    function get(string name) public constant returns (Executor executor, bytes abi);
    function remove(string name) public;

}
