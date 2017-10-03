pragma solidity ^0.4.15;

// @todo add this directly into the proposal potentially
import "./ballot/BallotInterface.sol";
import "./ExecutorInterface.sol";

contract ProposalInterface {

    BallotInterface public ballot;
    ExecutorInterface public executor;

    function execute() external;
    function setWinningOption(uint option) external;
    function isVoting() external constant returns (bool);
    function isEnded() external constant returns (bool);
    function isAccepted() public constant returns (bool);
    function canExecute() public constant returns (bool);
    function isExecuted() public constant returns (bool);

}
