pragma solidity ^0.4.11;

import "../ownership/ownable.sol";
import "../proposals/Proposal.sol";
import "./VotingInterface.sol";

contract Voting is VotingInterface, ownable {

    struct ProposalData {
        bool approved;

        address creator;
        address proposal;

        address[] voters;
        mapping (address => bool) voted;
        mapping (address => uint8) choices;
    }

    ProposalData[] proposals;

    /// @dev Creates a new proposal and stores it.
    /// @param creator Address of the proposal creator.
    /// @param proposal Address of the proposal contract.
    /// @return id of the created proposal.
    function create(address creator, address proposal) external onlyOwner returns (uint) {
        uint id = proposals.length;
        proposals.length++;

        ProposalData storage data = proposals[id];
        data.creator = creator;
        data.proposal = proposal;
        data.approved = false;

        return id;
    }

    /// @dev Votes on a proposal.
    /// @param id Id of the proposal.
    /// @param voter Address of the voter.
    /// @param choice Users selected voting choice.
    function vote(uint id, address voter, uint8 choice) external onlyOwner {
        require(!proposals[id].voted[voter]);
        require(isValidChoice(id, choice));

        ProposalData storage proposal = proposals[id];
        proposal.voters.push(voter);
        proposal.choices[voter] = choice;
        proposal.voted[voter] = true;
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

    function voters(uint id) constant returns (address[]) {
        return proposals[id].voters;
    }

    function choice(uint id, address voter) constant returns (uint8) {
        return proposals[id].choices[voter];
    }

    function hasVoted(uint id, address voter) constant returns (bool) {
        return proposals[id].voted[voter];
    }
}
