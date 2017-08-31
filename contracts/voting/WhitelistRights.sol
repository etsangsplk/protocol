pragma solidity ^0.4.11;

import "./VotingRightsInterface.sol";

contract WhitelistRights is VotingRightsInterface {

    mapping (address => bool) public whitelisted;

    function WhitelistRights(address[] whitelisters) {
        for (uint i = 0; i < whitelisters.length; i++) {
            whitelisted[whitelisters[i]] = true;
        }
    }

    function canVote(address voter) constant returns (bool) {
        return whitelisted[voter];
    }

    function canPropose(address proposer) constant returns (bool) {
        return whitelisted[proposer];
    }

    function canApprove(address approver) constant returns (bool) {
        return false;
    }

    function requiresApproval(uint proposal) constant returns (bool) {
        return false;
    }
}
