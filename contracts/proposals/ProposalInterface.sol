pragma solidity ^0.4.15;

contract ProposalInterface {

    uint8[] public options;
    bool public executed;

    function execute(uint8 option) external;
    function wasExecuted() external constant returns (bool);
    function isValidOption(uint8 option) external constant returns (bool);
    function getOptionsLength() external constant returns (uint);

}
