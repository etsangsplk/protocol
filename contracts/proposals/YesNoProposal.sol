pragma solidity ^0.4.11;

import "./Proposal.sol";

contract YesNoProposal is Proposal {

    uint8[] public choices = [0, 1];

}
