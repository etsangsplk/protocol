pragma solidity ^0.4.11;

import "../tokens/ERC20.sol";
import "../ownership/ownable.sol";

contract Proposal is ownable {

    address[] public voters;
    uint8[] public validChoices;
    address public creator;
    uint public deadline;
    bool public approved = false;

    mapping (address => bool) voted;
    mapping (address => uint8) choices;

    event Voted(address indexed voter, uint8 choice);

    function Proposal(uint8[] _choices) {
        for (uint i = 0; i < _choices.length; i++) {
            validChoices.push(_choices[i]);
        }
    }

    function vote(address voter, uint8 choice) external onlyOwner {
        assert(isValidChoice(choice));
        require(approved);
        require(!voted[voter]);

        voters.push(voter);
        choices[voter] = choice;
        voted[voter] = true;

        Voted(voter, choice);
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
