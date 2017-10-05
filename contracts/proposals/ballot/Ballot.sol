pragma solidity ^0.4.15;

import "./BallotInterface.sol";

contract Ballot is BallotInterface {

    enum Mode {Reject, Accept}

    struct Option {
        bytes32 label;
        bytes32 data;
        Mode mode;
    }

    Option[] public options;

    function Ballot(bytes32[] labels, bytes32[] data, bool[] willAccept) {
        for (uint256 i = 0; i < labels.length; i++) {
            Mode mode = Mode.Accept;
            if (!willAccept) {
                mode = Mode.Reject;
            }

            options.push(Option({label: label, data: data, mode: mode}));
        }
    }

    function getOptionsLength() external constant returns (uint) {
        return options.length;
    }

    function optionWillAccept(uint index) external constant returns (bool) {
        return options[index].mode == Mode.Accept;
    }

    function getLabel(uint index) external constant returns (bytes32) {
        return options[index].label;
    }

    function getData(uint index) external constant returns (bytes32) {
        return options[index].data;
    }

    function getOption(uint index) external constant returns (bytes32, bytes32, bool) {
        Option storage option = options[index];
        return (option.label, option.data, option.mode == Mode.Accept);
    }
}
