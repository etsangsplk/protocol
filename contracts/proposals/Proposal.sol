pragma solidity ^0.4.11;

import "../ownership/ownable.sol";

contract Proposal is ownable {

    address[] public voters;
    uint8[] public validChoices;
    address public creator;
    uint public deadline;

    function Proposal(uint8[] _choices) {
        for (uint i = 0; i < _choices.length; i++) {
            validChoices.push(_choices[i]);
        }
    }

    function approve() external onlyOwner {
        approved = true;
    }

    function unapprove() external onlyOwner {
        approved = false;
    }

    function deadline() constant returns (uint) {
        return deadline;
    }

    function isApproved() constant returns (bool) {
        return approved;
    }

    function choice(address voter) constant returns (uint8) {
        return choices[voter];
    }

    function voters() constant returns (address[]) {
        return voters;
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
