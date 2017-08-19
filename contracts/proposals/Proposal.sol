pragma solidity ^0.4.11;

import "../ownership/ownable.sol";

contract Proposal is ownable {

    uint8[] public validChoices;

    function Proposal(uint8[] _choices) {
        for (uint i = 0; i < _choices.length; i++) {
            validChoices.push(_choices[i]);
        }
    }

    function isValidChoice(uint8 _choice) constant returns (bool) {
        for (uint i = 0; i < validChoices.length; i++) {
            if (validChoices[i] == _choice) {
                return true;
            }
        }

        return false;
    }
}
