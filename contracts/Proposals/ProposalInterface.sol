pragma solidity 0.4.18;

// @todo add this directly into the proposal potentially
import "./Ballot/BallotInterface.sol";
import "./ExecutorInterface.sol";

interface ProposalInterface {

    function execute() external;
    function setWinningOption(uint option) external;
    function isVoting() external view returns (bool);
    function isEnded() external view returns (bool);
    function ballot() external view returns (BallotInterface);
    function executor() external view returns (ExecutorInterface);
    function isAccepted() public view returns (bool);
    function canExecute() public view returns (bool);
    function isExecuted() public view returns (bool);
    function createdAt() public view returns (uint);

}
