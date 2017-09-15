pragma solidity ^0.4.11;

import "./ProposalInterface.sol";
import "../ownership/ownable.sol";

contract Proposal is ProposalInterface, ownable {

    bool public executed = false;

    modifier onlyBeforeExecuted() { require(!executed); _; }

    function wasExecuted() external constant returns (bool) {
        return executed;
    }

    function isValidChoice(uint8 _choice) external constant returns (bool) {
        for (uint i = 0; i < choices.length; i++) {
            if (choices[i] == _choice) {
                return true;
            }
        }

        return false;
    }

    function getChoicesLength() external constant returns (uint) {
        return choices.length;
    }
}
