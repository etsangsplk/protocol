pragma solidity ^0.4.18;

interface ProposalManagerInterface {

    function add(address creator, address proposal) external returns (uint);
    function approve(uint id) external;
    function isApproved(uint id) external view returns (bool);
    function getProposal(uint id) external view returns (address);

}
