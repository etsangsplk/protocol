pragma solidity ^0.4.11;

import "../../contracts/proposals/YesNoProposal.sol";

contract ProposalMock is YesNoProposal {
    function execute() external onlyBeforeExecuted { }
}
