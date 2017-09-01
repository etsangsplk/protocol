pragma solidity ^0.4.11;

import "../ownership/ownable.sol";
import "./VotingManagerInterface.sol";

contract VotingManager is VotingManagerInterface, ownable {

    // @todo this name fucking sucks
    struct Votes {
        address[] voters;
        mapping (address => uint8) choice;
        mapping (address => bool) voted;
    }

    mapping (uint => Votes) voting;

    /// @dev Votes on proposal.
    /// @param proposal Id of the proposal to vote on.
    /// @param voter Address of the voter.
    /// @param choice Voters selected choice.
    function vote(uint proposal, address voter, uint8 choice) external onlyOwner {
        require(!voted(proposal, voter));

        Votes votes = voting[proposal];
        votes.choice[voter] = choice;
        votes.voted[voter] = true;
    }

    /// @dev Whether a voter has voted on a specific proposal.
    /// @param proposal Id of the proposal.
    /// @param voter Address of the voter.
    function voted(uint proposal, address voter) public constant returns (bool) {
        return voting[proposal].voted[voter];
    }

    /// @dev Choice a voter has selected for a specific proposal.
    /// @param proposal Id of the proposal.
    /// @param voter Address of the voter.
    function choice(uint proposal, address voter) external constant returns (uint8) {
        return voting[proposal].choice[voter];
    }
}
