pragma solidity ^0.4.15;

import "./ProposalInterface.sol";

contract Proposal is ProposalInterface {

    // @todo when we have plamsa we may be able to remove this, as we could potentially guarantee a stable blocktime then.
    struct TimeSpan {
        UnitOfTime unit;
        uint256 start;
        uint256 end;
    }

    enum UnitOfTime { Block, Timestamp }
    enum State { Accepted, Rejected }

    State public state;
    TimeSpan public timeSpan;

    uint public winningOption;
    bool public tallied = false;
    bool public executed = false;

    BallotInterface public ballot;
    ExecutorInterface public executor;

    function Proposal(BallotInterface _ballot, bool isBlockNumber, uint256 start, uint256 end) {
        ballot = _ballot;

        UnitOfTime unit = UnitOfTime.Block;
        if (!isBlockNumber) {
            unit = UnitOfTime.Timestamp;
        }

        timeSpan = TimeSpan({unit: unit, start: start, end: end});
    }

    function execute() external {
        require(canExecute() && isAccepted() && !isExecuted());
        executor.execute(this);
        executed = true;
    }

    // @todo this is ugly, only make it settable once
    function setWinningOption(uint option) external {
        require(!tallied);

        if (ballot.optionWillAccept(option)) {
            state = State.Accepted;
        } else {
            state = State.Rejected;
        }

        winningOption = option;
        tallied = true;
    }

    function isVoting() external constant returns (bool) {
        if (timeSpan.unit == UnitOfTime.Block) {
            return timeSpan.start >= block.number && block.number <= timeSpan.end;
        }

        return timeSpan.start >= block.timestamp && block.timestamp <= timeSpan.end;
    }

    function isEnded() external constant returns (bool) {
        if (timeSpan.unit == UnitOfTime.Block) {
            return timeSpan.end < block.number;
        }

        return timeSpan.end < block.timestamp;
    }

    function isAccepted() public constant returns (bool) {
        return state == State.Accepted;
    }

    function canExecute() public constant returns (bool) {
        return address(executor) != 0x0;
    }

    function isExecuted() public constant returns (bool) {
        return executed;
    }
}
