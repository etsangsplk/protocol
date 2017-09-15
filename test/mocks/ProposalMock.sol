pragma solidity ^0.4.15;

import "../../contracts/proposals/YesNoProposal.sol";

contract ProposalMock is YesNoProposal {
    function execute(uint8 choice) external onlyBeforeExecuted onlyOwner { }
}
