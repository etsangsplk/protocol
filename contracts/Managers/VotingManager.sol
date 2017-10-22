pragma solidity ^0.4.15;

import "../Ownership/Ownable.sol";
import "./VotingManagerInterface.sol";

contract VotingManager is VotingManagerInterface, Ownable {

    struct VoteData {
        uint256 quorum;
        mapping (uint => uint256) choices; // @todo unituitive name
        mapping (address => bool) voted;
    }

    mapping (uint => VoteData) proposalVotes;

    /// @dev Votes on proposal.
    /// @param proposal Id of the proposal to vote on.
    /// @param voter Address of the voter.
    /// @param choice Voters selected option.
    function vote(uint proposal, address voter, uint choice, uint256 weight) external onlyOwner {
        require(!voted(proposal, voter));

        VoteData storage data = proposalVotes[proposal];
        data.quorum += weight;
        data.choices[choice] += weight;
        data.voted[voter] = true;
    }

    /// @dev Amount votes count for a option on a proposal.
    /// @param proposal Id of the proposal.
    /// @param choice Selected option.
    /// @return count of votes for option.
    function votes(uint proposal, uint choice) external constant returns (uint256) {
        return proposalVotes[proposal].choices[choice];
    }

    /// @dev Whether a voter has voted on a specific proposal.
    /// @param proposal Id of the proposal.
    /// @param voter Address of the voter.
    function voted(uint proposal, address voter) public constant returns (bool) {
        return proposalVotes[proposal].voted[voter];
    }

    /// @dev Returns the achieved quorum for Proposal.
    /// @param proposal Id of the proposal.
    /// @return quorum of votes
    function quorum(uint proposal) public constant returns (uint256) {
        return proposalVotes[proposal].quorum;
    }
}
