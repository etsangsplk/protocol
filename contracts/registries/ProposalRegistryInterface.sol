pragma solidity ^0.4.11;

contract ProposalRegistryInterface {

    event ProposalAdded(string name);
    event ProposalRemoved(string name);

    function create(string name, bytes arguments) public constant returns (address);
    function add(string name, bytes code, bytes abi) public;
    function get(string name) public constant returns (bytes abi, bytes code);
    function remove(string name) public;

}
