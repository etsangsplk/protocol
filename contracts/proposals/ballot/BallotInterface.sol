pragma solidity ^0.4.15;

contract BallotInterface {

    function getOptionsLength() external constant returns (uint);
    function optionWillAccept(uint index) external constant returns (bool);
    function getLabel(uint index) external constant returns (string);
    function getData(uint index) external constant returns (bytes32);
    function getOption(uint index) external constant returns (string, bytes32, bool);

}
