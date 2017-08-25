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
}
