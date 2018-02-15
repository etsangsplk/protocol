pragma solidity ^0.4.19;

import "./ProposalInterface.sol";

// @todo lets clean this up. Potentially turn it into a struct to keep it more lightweight.
// @todo cleanup ballot creation
contract Proposal is ProposalInterface {

    // @todo when we have plamsa we may be able to remove this, as we could potentially guarantee a stable blocktime then.
    struct TimeSpan {
        UnitOfTime unit;
        uint start;
        uint end;
    }

    enum UnitOfTime { Block, Timestamp }
    enum State { Accepted, Rejected }

    State public state;
    TimeSpan public timeSpan;

    uint public createdAt;
    uint public winningOption;
    bool public tallied = false;
    bool public executed = false;

    BallotInterface public ballot;
    ExecutorInterface public executor;

    function Proposal(BallotInterface _ballot, bool isBlockNumber, uint start, uint end) public {
        ballot = _ballot;

        UnitOfTime unit = UnitOfTime.Block;
        if (!isBlockNumber) {
            unit = UnitOfTime.Timestamp;
        }

        timeSpan = TimeSpan({unit: unit, start: start, end: end});
        createdAt = (block.number - 1);
    }

    // @todo remove this, lets put this into Org contract
    function execute() external {
        require(canExecute() && isAccepted() && !isExecuted());
        executed = true;
        executor.execute(this);
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

    function isVoting() external view returns (bool) {
        if (timeSpan.unit == UnitOfTime.Block) {
            return block.number >= timeSpan.start && block.number <= timeSpan.end;
        }

        return block.timestamp >= timeSpan.start && block.timestamp <= timeSpan.end;
    }

    function isEnded() external view returns (bool) {
        if (timeSpan.unit == UnitOfTime.Block) {
            return timeSpan.end < block.number;
        }

        return timeSpan.end > block.timestamp;
    }

    function ballot() external view returns (BallotInterface) {
        return ballot;
    }

    function executor() external view returns (ExecutorInterface) {
        return executor;
    }

    function isAccepted() public view returns (bool) {
        return state == State.Accepted;
    }

    function canExecute() public view returns (bool) {
        return address(executor) != 0x0;
    }

    function isExecuted() public view returns (bool) {
        return executed;
    }

    function createdAt() public view returns (uint) {
        return createdAt;
    }
}
