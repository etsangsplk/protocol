pragma solidity ^0.4.15;

import "./ProposalInterface.sol";
import "../ownership/ownable.sol";

contract Proposal is ProposalInterface, ownable {

    bool public executed = false;

    modifier onlyBeforeExecuted() { require(!executed); _; }

    function wasExecuted() external constant returns (bool) {
        return executed;
    }

    function isValidOption(uint8 option) external constant returns (bool) {
        for (uint i = 0; i < options.length; i++) {
            if (options[i] == option) {
                return true;
            }
        }

        return false;
    }

    function getOptionsLength() external constant returns (uint) {
        return options.length;
    }
}
