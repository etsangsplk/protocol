pragma solidity 0.4.18;

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

    uint public quorum;
    uint public optionsLength;

    mapping (address => Vote) public votes;
    mapping (uint => Option) public options;

    function Ballot(bytes32[] labels, bytes32[] data, bool[] willAccept) public {
        require(labels.length == data.length && labels.length == willAccept.length);

        optionsLength = labels.length;

        for (uint i = 0; i < optionsLength; i++) {
            Mode mode = Mode.Accept;
            if (!willAccept[i]) {
                mode = Mode.Reject;
            }

            options[i] = Option({votes: 0, label: labels[i], data: data[i], mode: mode});
        }
    }

    /// @dev Votes for a specified choice
    /// @param voter Address of the voter.
    /// @param choice Voters selected option.
    function vote(address voter, uint choice, uint weight) external onlyOwner {
        require(!voted(voter));
        require(weight > 0);

        quorum += weight;
        options[choice].votes += weight;

        votes[voter] = Vote({choice: choice, weight: weight});
    }

    /// @dev Undoes a voters votes for a choice.
    /// @param voter Address of the voter.
    function unvote(address voter) external onlyOwner {
        require(voted(voter));

        Vote storage vote = votes[voter];

        quorum -= vote.weight;
        options[vote.choice].votes -= vote.weight;

        delete votes[voter];
    }

    function optionWillAccept(uint index) external view returns (bool) {
        return options[index].mode == Mode.Accept;
    }

    function getLabel(uint index) external view returns (bytes32) {
        return options[index].label;
    }

    function getData(uint index) external view returns (bytes32) {
        return options[index].data;
    }

    function isValidChoice(uint index) external view returns (bool) {
        return optionsLength > index;
    }

    function optionsLength() external view returns (uint) {
        return optionsLength;
    }

    function quorum() external view returns (uint) {
        return quorum;
    }

    /// @dev Amount votes count for a option on a proposal.
    /// @param choice Selected option.
    /// @return count of votes for option.
    function votes(uint choice) external view returns (uint) {
        return options[choice].votes;
    }

    /// @dev Whether a voter has voted on a specific proposal.
    /// @param voter Address of the voter.
    function voted(address voter) public view returns (bool) {
        return votes[voter].weight > 0;
    }
}
