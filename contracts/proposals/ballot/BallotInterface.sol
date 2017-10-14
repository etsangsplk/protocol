pragma solidity ^0.4.15;

contract BallotInterface {

    uint256 public optionsLength;

    function optionWillAccept(uint index) external constant returns (bool);
    function getLabel(uint index) external constant returns (bytes32);
    function getData(uint index) external constant returns (bytes32);
    function getOption(uint index) external constant returns (bytes32, bytes32, bool);

}
