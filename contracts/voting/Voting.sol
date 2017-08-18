pragma solidity ^0.4.11;

import "../ownership/ownable.sol";
import "../proposals/Proposal.sol";

contract Voting is ownable {

    struct ProposalData {
        bool approved;

        address creator;
        address proposal;

        address[] voters;
        mapping (address => bool) voted;
        mapping (address => uint8) choices;
    }

    ProposalData[] proposals;

    function vote(uint id, address voter, uint8 choice) external onlyOwner {
        require(!proposals[id].voted[voter]);
        require(isValidChoice(id, choice));

        ProposalData storage proposal = proposals[id];
        proposal.voters.push(voter);
        proposal.choices[voter] = choice;
        proposal.voted[voter] = true;
    }

    function approve(uint id) external onlyOwner {
        proposals[id].approved = true;
    }

    function isApproved(uint id) constant returns (bool) {
        return proposals[id].approved;
    }

    function isValidChoice(uint id, uint8 choice) constant returns (bool) {
        return Proposal(proposals[id].proposal).isValidChoice(choice);
    }
}
