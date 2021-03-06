pragma solidity ^0.4.20;

import "./ExecutorInterface.sol";

contract AbstractExecutor is ExecutorInterface {

    function execute(address proposal) external {
        require(msg.sender == proposal);
        doExecute(this);
    }

    function doExecute(address proposal) private;

}
