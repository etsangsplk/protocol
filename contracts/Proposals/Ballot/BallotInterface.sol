pragma solidity ^0.4.15;

contract BallotInterface {

    enum Mode {Reject, Accept}

    struct Option {
        bytes32 label;
        bytes32 data;
        Mode mode;
    }

    uint256 public optionsLength;

    mapping (uint => Option) public options;


    function optionWillAccept(uint index) external constant returns (bool);
    function getLabel(uint index) external constant returns (bytes32);
    function getData(uint index) external constant returns (bytes32);

}
