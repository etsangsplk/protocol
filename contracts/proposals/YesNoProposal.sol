pragma solidity ^0.4.15;

import "./Proposal.sol";

contract YesNoProposal is Proposal {

    uint8[] public option = [0, 1];

}
