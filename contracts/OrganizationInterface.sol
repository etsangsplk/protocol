pragma solidity ^0.4.18;

import "./Managers/ProposalManagerInterface.sol";

interface OrganizationInterface {

    function vote(uint proposal, uint choice) external;
    function approve(uint proposal) external;
    function propose(address proposalAddress) external;
    function execute(uint id) external;
    function tally(uint id) external;
    function proposalManager() external view returns (ProposalManagerInterface);
    function quorumReached(uint id) public view returns (bool);
    function winningOption(uint id) public view returns (uint);

}
