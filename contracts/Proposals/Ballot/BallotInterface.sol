pragma solidity 0.4.18;

interface BallotInterface {

    function optionWillAccept(uint index) external view returns (bool);
    function getLabel(uint index) external view returns (bytes32);
    function getData(uint index) external view returns (bytes32);
    function isValidChoice(uint index) external view returns (bool);
    function optionsLength() external view returns (uint256);

}
