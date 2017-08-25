pragma solidity ^0.4.11;

import "../ownership/ownable.sol";
import "../proposals/Proposal.sol";
import "./VotingInterface.sol";

contract Voting is VotingInterface, ownable {

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
