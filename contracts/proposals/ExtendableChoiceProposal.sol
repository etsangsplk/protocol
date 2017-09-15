pragma solidity ^0.4.15;

import "./Proposal.sol";

contract ExtendableChoiceProposal is Proposal {

    function ExtendableChoiceProposal(uint8[] _choices) {
        for (uint i = 0; i < _choices.length; i++) {
            choices.push(_choices[i]);
        }
    }
}
