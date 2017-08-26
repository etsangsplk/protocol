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

    /// @dev Returns voters for proposal.
    /// @param id Id of the proposal.
    /// @return address[] All voter addresses
    function voters(uint id) constant returns (address[]) {
        return proposals[id].voters;
    }

    /// @dev Returns choice selected by voter.
    /// @param id Id of the proposal.
    /// @param voter Address of the voter.
    /// @return uint8 Value of the selected choice.
    function choice(uint id, address voter) constant returns (uint8) {
        return proposals[id].choices[voter];
    }

    function hasVoted(uint id, address voter) constant returns (bool) {
        return proposals[id].voted[voter];
    }

    function appendVote(uint id, address voter, uint8 choice) external onlyOwner {
        ProposalData storage proposal = proposals[id];
        proposal.voters.push(voter);
        proposal.choices[voter] = choice;
        proposal.voted[voter] = true;
    }
}
