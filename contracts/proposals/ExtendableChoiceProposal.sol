pragma solidity ^0.4.15;

import "./Proposal.sol";

contract ExtendableOptionsProposal is Proposal {

    function ExtendableOptionsProposal(uint8[] _options) {
        for (uint i = 0; i < _options.length; i++) {
            options.push(_options[i]);
        }
    }
}
