pragma solidity ^0.4.18;

interface BallotInterface {

    function vote(address voter, uint choice, uint weight) external;
    function unvote(address voter) external;
    function nextRound(uint[2] choices) external;
    function optionWillAccept(uint index) external view returns (bool);
    function getLabel(uint index) external view returns (bytes32);
    function getData(uint index) external view returns (bytes32);
    function isValidChoice(uint index) external view returns (bool);
    function optionsLength() external view returns (uint);
    function quorum() external view returns (uint);
    function votes(uint choice) external view returns (uint);
    function voted(address voter) public view returns (bool);
}
