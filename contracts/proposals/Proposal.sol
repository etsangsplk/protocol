pragma solidity ^0.4.11;

import "../ownership/ownable.sol";

contract Proposal is ownable {

    uint8[] public choices;

    function Proposal(uint8[] _choices) {
        for (uint i = 0; i < _choices.length; i++) {
            choices.push(_choices[i]);
        }
    }

    function isValidChoice(uint8 _choice) constant returns (bool) {
        for (uint i = 0; i < choices.length; i++) {
            if (choices[i] == _choice) {
                return true;
            }
        }

        return false;
    }
}
