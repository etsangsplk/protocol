pragma solidity ^0.4.11;

import "../ownership/ownable.sol";
import "./VotingManagerInterface.sol";

contract VotingManager is VotingManagerInterface, ownable {

    struct VoteData {
        mapping (uint8 => uint256) choices; // @todo unituitive name
        mapping (address => bool) voted;
    }

    mapping (uint => VoteData) proposalVotes;

    /// @dev Votes on proposal.
    /// @param proposal Id of the proposal to vote on.
    /// @param voter Address of the voter.
    /// @param choice Voters selected choice.
    function vote(uint proposal, address voter, uint8 choice, uint256 weight) external onlyOwner {
        require(!voted(proposal, voter));

        VoteData storage data = proposalVotes[proposal];
        data.choices[choice] += weight;
        data.voted[voter] = true;
    }

    /// @dev Whether a voter has voted on a specific proposal.
    /// @param proposal Id of the proposal.
    /// @param voter Address of the voter.
    function voted(uint proposal, address voter) public constant returns (bool) {
        return proposalVotes[proposal].voted[voter];
    }

    /// @dev Amount votes count for a choice on a proposal.
    /// @param proposal Id of the proposal.
    /// @param choice Selected choice.
    /// @return count of votes for choice.
    function votes(uint proposal, uint8 choice) public constant returns (uint256) {
        return proposalVotes[proposal].choices[choice];
    }
}
