pragma solidity ^0.4.11;

contract ProposalRegistryInterface {

    event ProposalAdded(string name);
    event ProposalRemoved(string name);

    function add(string name, bytes code, bytes abi) external;
    function remove(string name) external;
    function create(string name, bytes arguments) external constant returns (address);
    function get(string name) external constant returns (bytes abi, bytes code);

}
