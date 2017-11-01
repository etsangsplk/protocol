pragma solidity 0.4.18;

import "./Managers/ProposalManagerInterface.sol";
import "./Managers/VotingManagerInterface.sol";

interface OrganizationInterface {

    function vote(uint proposal, uint choice) external;
    function approve(uint proposal) external;
    function propose(address proposalAddress) external;
    function execute(uint id) external;
    function tally(uint id) external;
    function proposalManager() external view returns (ProposalManagerInterface);
    function votingManager() external view returns (VotingManagerInterface);
    function winningOption(uint id) public view returns (uint256);

}
