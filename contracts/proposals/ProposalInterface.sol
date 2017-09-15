pragma solidity ^0.4.15;

contract ProposalInterface {

    uint8[] public choices;
    bool public executed;

    function execute(uint8 choice) external;
    function wasExecuted() external constant returns (bool);
    function isValidChoice(uint8 _choice) external constant returns (bool);
    function getChoicesLength() external constant returns (uint);

}
