pragma solidity ^0.4.11;

import "./VotingStrategy.sol";
import { ERC20 as Token } from "../tokens/ERC20.sol";

contract TokenVotingStrategy is VotingStrategy {

    Token public token;

    function TokenVotingStrategy(Token _token) {
        token = _token;
    }

    function quorumReached(uint proposal) constant returns (bool) {
        return false; // @todo
    }

    function proposalPassed(uint proposal) constant returns (bool) {
        return false; // @todo
    }

}
