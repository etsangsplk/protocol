pragma solidity ^0.4.11;

contract ProposalManagerInterface {

    function add(address creator, address proposal) external returns (uint);
    function approve(uint id) external;
    function isApproved(uint id) constant returns (bool);

}
