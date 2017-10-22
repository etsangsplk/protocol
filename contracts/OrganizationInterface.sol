pragma solidity ^0.4.15;

import "./Managers/ProposalManagerInterface.sol";
import "./Managers/VotingManagerInterface.sol";

contract OrganizationInterface {

    ProposalManagerInterface public proposalManager;
    VotingManagerInterface public votingManager;

    function vote(uint proposal, uint choice) external;
    function approve(uint proposal) external;
    function propose(address proposalAddress) external;
    function execute(uint id) external;
    function tally(uint id) external;
    function winningOption(uint id) public constant returns (uint256);

}
