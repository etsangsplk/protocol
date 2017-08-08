pragma solidity ^0.4.11;

import "../tokens/ERC20.sol";

contract Proposal {

    address[] public voters;
    uint8[] public choices;
    address public creator;
    uint public deadline;

    mapping (address => bool) voted;
    mapping (address => uint8) votes;

    event Voted(address indexed voter, uint8 choice);

    function Proposal(uint8[] _choices) {
        choices = _choices;
        creator = msg.sender;
    }

    function vote(uint8 choice) external {
        assert(isValidChoice(choice));
        require(!voted[msg.sender]);

        voters.push(msg.sender);
        votes[msg.sender] = choice;
        voted[msg.sender] = true;

        Voted(msg.sender, choice);
    }

    function deadline() constant returns (uint) {
        return deadline;
    }

    function voted(address voter) constant returns (bool) {
        return voted[voter];
    }

    function choice(address voter) constant returns (uint8) {
        return votes[voter];
    }

    function voters() constant returns (address[]) {
        return voters;
    }

    function isValidChoice(uint8 _choice) constant returns (bool) {
        for (uint i = 0; i < choices.length; i++) {
            if (choices[i] == _choice) {
                return true;
            }
        }

        return false;
    }

    // @todo move into quorum contract
    /*function didPass() returns (bool) {
        uint yes = 0;
        uint no = 0;

        for (uint i = 0; i < votes.length; i++) {
            Vote memory vote = votes[i];
            uint voteBalance = token.balanceOf(vote.voter);

            if (vote.inFavour) {
                yes += voteBalance;
                continue;
            }

            no += voteBalance;
        }

        return yes > no;
    }

    function getVoterQuorum() returns (uint) {
        uint sum = 0;
        for (uint i = 0; i < votes.length; i++) {
            sum += token.balanceOf(votes[i].voter);
        }

        return (sum / token.totalSupply()) * 100;
    }*/
}
