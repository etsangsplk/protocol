pragma solidity ^0.4.11;

import "../ownership/ownable.sol";

contract ProposalManager is ownable {

    struct ProposalData {
        bool approved;

        address creator;
        address proposal;

        address[] voters;
        mapping (address => bool) voted;
        mapping (address => uint8) choices;
    }

    ProposalData[] proposals;

    /// @dev Adds a new proposal.
    /// @param creator Address of the proposal creator.
    /// @param proposal Address of the proposal contract.
    /// @return id of the proposal.
    function add(address creator, address proposal) external onlyOwner returns (uint) {
        uint id = proposals.length;
        proposals.length++;

        ProposalData storage data = proposals[id];
        data.creator = creator;
        data.proposal = proposal;
        data.approved = false;

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
    function isApproved(uint id) constant returns (bool) {
        return proposals[id].approved;
    }

    /// @dev Checks if a choice is valid
    /// @param id Id of the proposal.
    /// @param choice Users selected voting choice.
    /// @return bool if choice is valid.
    function isValidChoice(uint id, uint8 choice) constant returns (bool) {
        return Proposal(proposals[id].proposal).isValidChoice(choice);
    }
}
