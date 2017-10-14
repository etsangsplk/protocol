pragma solidity ^0.4.15;

import "../ownership/ownable.sol";
import "./ProposalManagerInterface.sol";

contract ProposalManager is ProposalManagerInterface, ownable {

    struct ProposalData {
        bool approved;

        address creator;
        address proposal;
    }

    uint256 public nextId = 0;

    mapping (uint => ProposalData) public proposals;

    /// @dev Adds a new proposal.
    /// @param creator Address of the proposal creator.
    /// @param proposal Address of the proposal contract.
    /// @return id of the proposal.
    function add(address creator, address proposal) external onlyOwner returns (uint) {
        uint256 id = nextId;
        nextId++;

        proposals[id] = ProposalData({
            creator: creator,
            proposal: proposal,
            approved: false
        });

        return id;
    }

    /// @dev Approves a proposal.
    /// @param id Id of the proposal.
    function approve(uint id) external onlyOwner {
        proposals[id].approved = true;
    }

    /// @dev Checks if a proposal has been approved.
    /// @param id Id of the proposal.
    /// @return bool if proposal is approved.
    function isApproved(uint id) external constant returns (bool) {
        return proposals[id].approved;
    }

    /// @dev Returns proposal address
    /// @param id If of the proposal.
    /// @return address of the proposal.
    function getProposal(uint id) external constant returns (address) {
        return proposals[id].proposal;
    }
}
