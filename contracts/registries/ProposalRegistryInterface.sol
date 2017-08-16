pragma solidity ^0.4.11;

import "../executors/Executor.sol";

contract ProposalRegistryInterface {

    event ProposalAdded(string name);
    event ProposalRemoved(string name);

    function create(string name, bytes arguments) public constant returns (address);
    function add(string name, Executor executor, bytes code, bytes abi) public;
    function get(string name) public constant returns (Executor executor, bytes abi, bytes code);
    function remove(string name) public;

}
