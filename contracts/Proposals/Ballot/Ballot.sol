pragma solidity ^0.4.19;

import "./../../Ownership/Ownable.sol";
import "./BallotInterface.sol";

contract Ballot is Ownable, BallotInterface {

    enum Mode {Reject, Accept}

    struct Option {
        uint256 votes;
        bytes32 label;
        bytes32 data;
        Mode mode;
    }

    struct Vote {
        uint weight;
        uint choice;
    }

    struct Round {
        mapping (address => Vote) votes;
        mapping (uint => Option) options;

        uint optionsLength;
    }

    uint public quorum;
    uint public votingRound;

    mapping (uint => Round) rounds;

    function Ballot(bytes32[] labels, bytes32[] data, bool[] willAccept) public {
        require(labels.length == data.length && labels.length == willAccept.length);

        votingRound = 0;
        rounds[votingRound].optionsLength = labels.length;

        uint length = rounds[votingRound].optionsLength;
        for (uint i = 0; i < length; i++) {
            Mode mode = Mode.Accept;
            if (!willAccept[i]) {
                mode = Mode.Reject;
            }

            rounds[votingRound].options[i] = Option({votes: 0, label: labels[i], data: data[i], mode: mode});
        }
    }

    /// @dev Votes for a specified choice
    /// @param voter Address of the voter.
    /// @param choice Voters selected option.
    function vote(address voter, uint choice, uint weight) external onlyOwner {
        require(!voted(voter));
        require(weight > 0);

        quorum += weight;

        rounds[votingRound].options[choice].votes += weight;
        rounds[votingRound].votes[voter] = Vote({choice: choice, weight: weight});
    }

    /// @dev Undoes a voters votes for a choice.
    /// @param voter Address of the voter.
    function unvote(address voter) external onlyOwner {
        require(voted(voter));

        Vote storage vote = rounds[votingRound].votes[voter];

        quorum -= vote.weight;
        rounds[votingRound].options[vote.choice].votes -= vote.weight;

        delete rounds[votingRound].votes[voter];
    }

    /// @dev Starts a new voting round with choices.
    /// @param choices Choices included in the next round.
    function nextRound(uint[2] choices) external onlyOwner {

        uint256 previousVotingRound = votingRound;
        votingRound = votingRound + 1;

        rounds[votingRound].optionsLength = choices.length;

        uint length = choices.length;
        for (uint i = 0; i < length; i++) {
            Option storage previous = rounds[previousVotingRound].options[choices[i]];
            rounds[votingRound].options[i] = Option({
                votes: 0,
                label: previous.label,
                data: previous.data,
                mode: previous.mode
            });
        }
    }

    function optionWillAccept(uint index) external view returns (bool) {
        return rounds[votingRound].options[index].mode == Mode.Accept;
    }

    function getLabel(uint index) external view returns (bytes32) {
        return rounds[votingRound].options[index].label;
    }

    function getData(uint index) external view returns (bytes32) {
        return rounds[votingRound].options[index].data;
    }

    function isValidChoice(uint index) external view returns (bool) {
        return rounds[votingRound].optionsLength > index;
    }

    function optionsLength() external view returns (uint) {
        return rounds[votingRound].optionsLength;
    }

    function quorum() external view returns (uint) {
        return quorum;
    }

    /// @dev Amount votes count for a option on a proposal.
    /// @param choice Selected option.
    /// @return count of votes for option.
    function votes(uint choice) external view returns (uint) {
        return rounds[votingRound].options[choice].votes;
    }

    /// @dev Whether a voter has voted on a specific proposal.
    /// @param voter Address of the voter.
    function voted(address voter) public view returns (bool) {
        return rounds[votingRound].votes[voter].weight > 0;
    }
}
