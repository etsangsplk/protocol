pragma solidity ^0.4.15;

contract OrganizationInterface {

    function vote(uint proposal, uint choice) external;
    function approve(uint proposal) external;
    function propose(address proposalAddress) external;
    function execute(uint id) external;
    function tally(uint id) external;
    function winningOption(uint id) public constant returns (uint256);

}
