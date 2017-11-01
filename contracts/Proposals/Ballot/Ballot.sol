pragma solidity 0.4.18;

import "./BallotInterface.sol";

contract Ballot is BallotInterface {

    enum Mode {Reject, Accept}

    struct Option {
        bytes32 label;
        bytes32 data;
        Mode mode;
    }

    uint256 public optionsLength;

    mapping (uint => Option) public options;

    function Ballot(bytes32[] labels, bytes32[] data, bool[] willAccept) public {
        optionsLength = labels.length;

        for (uint256 i = 0; i < optionsLength; i++) {
            Mode mode = Mode.Accept;
            if (!willAccept[i]) {
                mode = Mode.Reject;
            }

            options[i] = Option({label: labels[i], data: data[i], mode: mode});
        }
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

    function optionsLength() external view returns(uint256) {
        return optionsLength;
    }
}
