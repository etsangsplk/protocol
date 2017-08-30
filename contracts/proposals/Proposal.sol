pragma solidity ^0.4.11;

import "../ownership/ownable.sol";

contract Proposal is ownable {

    uint8[] public choices;
    bool public executed = false;

    modifier onlyBeforeExecuted() { require(!executed); _; }

    function wasExecuted() constant returns (bool) {
        return executed;
    }

    function execute() external;

    function isValidChoice(uint8 _choice) public constant returns (bool) {
        for (uint i = 0; i < choices.length; i++) {
            if (choices[i] == _choice) {
                return true;
            }
        }

        return false;
    }
}
