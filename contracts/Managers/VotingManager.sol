pragma solidity 0.4.18;

import "../Ownership/Ownable.sol";
import "./VotingManagerInterface.sol";

contract VotingManager is VotingManagerInterface, Ownable {

    struct Vote {
        uint256 weight;
        uint256 choice;
    }

    struct VoteData {
        uint256 quorum;
        mapping (uint => uint256) choices; // @todo unituitive name

        // @todo lets see if we can do this nicer, but we need it so we unvote the correct amount in case value may
        // have changed.
        mapping (address => Vote) votes;
    }

    mapping (uint => VoteData) proposalVotes;

    /// @dev Votes on proposal.
    /// @param proposal Id of the proposal to vote on.
    /// @param voter Address of the voter.
    /// @param choice Voters selected option.
    function vote(uint proposal, address voter, uint choice, uint256 weight) external onlyOwner {
        require(!voted(proposal, voter));
        require(weight > 0);

        VoteData storage data = proposalVotes[proposal];
        data.quorum += weight;
        data.choices[choice] += weight;

        data.votes[voter] = Vote({choice: choice, weight: weight});
    }

    /// @dev Undoes a voters votes on a proposal.
    /// @param proposal Id of the proposal to unvote.
    /// @param voter Address of the voter.
    function unvote(uint proposal, address voter) external onlyOwner {
        require(voted(proposal, voter));

        VoteData storage data = proposalVotes[proposal];
        Vote storage vote = data.votes[voter];

        data.quorum -= vote.weight;
        data.choices[vote.choice] -= vote.weight;

        delete data.votes[voter];
    }

    /// @dev Amount votes count for a option on a proposal.
    /// @param proposal Id of the proposal.
    /// @param choice Selected option.
    /// @return count of votes for option.
    function votes(uint proposal, uint choice) external view returns (uint256) {
        return proposalVotes[proposal].choices[choice];
    }

    /// @dev Whether a voter has voted on a specific proposal.
    /// @param proposal Id of the proposal.
    /// @param voter Address of the voter.
    function voted(uint proposal, address voter) public view returns (bool) {
        return proposalVotes[proposal].votes[voter].weight > 0;
    }

    /// @dev Returns the achieved quorum for Proposal.
    /// @param proposal Id of the proposal.
    /// @return quorum of votes
    function quorum(uint proposal) public view returns (uint256) {
        return proposalVotes[proposal].quorum;
    }
}
