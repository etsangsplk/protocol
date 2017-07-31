pragma solidity ^0.4.11;

import "../../contracts/proposals/Proposal.sol";
import "../../contracts/executors/Executor.sol";
import "../../contracts/ownership/ownable.sol";

contract ExecutorMock is Executor {

    function execute(Proposal _proposal) onlyOwner returns (bool) {
        return true;
    }

    function destroy() onlyOwner {
        selfdestruct(owner);
    }
}
