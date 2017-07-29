pragma solidity ^0.4.11;

import "../tokens/ERC20.sol";

contract Proposal {

    struct Vote {
        address voter;
        bool inFavour;
        uint8 range;
    }

    Vote[] votes;
    address public creator;
    uint public deadline;

    mapping (address => bool) voted;

    event Voted(address indexed voter, bool inFavour);

    function voteRangeEnabled() returns (bool);
    function isValidVoteRange(uint8 _range) returns (bool);

    function deadline() constant returns (uint) {
        return deadline;
    }

    function vote(bool inFavour, uint8 _range) external {
        assert(!voted[msg.sender]);

        // ew
        uint8 _voteRange = 0;
        if (voteRangeEnabled()) {
            require(isValidVoteRange(_range));
            _voteRange = _range;
        }

        votes.push(Vote(msg.sender, inFavour, _voteRange));
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
