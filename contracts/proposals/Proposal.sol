pragma solidity ^0.4.11;

import "../tokens/ERC20.sol";

contract Proposal {

    struct Vote {
        address voter;
        bool inFavour;
    }

    Vote[] votes;
    address public creator;
    uint public deadline;

    mapping (address => bool) voted;

    event Voted(address indexed voter, bool inFavour);

    function deadline() constant returns (uint) {
        return deadline;
    }

    function vote(bool inFavour) external {
        assert(!voted[msg.sender]);

        votes.push(Vote(msg.sender, inFavour));
        voted[msg.sender] = true;

        Voted(msg.sender, inFavour);
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
