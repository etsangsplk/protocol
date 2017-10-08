pragma solidity ^0.4.15;

import "./MajoritySystemLibrary.sol";

contract AbsoluteMajoritySystemLibrary is MajoritySystemLibrary {

    function winningOption(uint256 id) constant returns (uint256) {

        uint256 winner = super.winningOption(id);
        uint256 quorum = votingManager.quorum(id);
        uint256 votes = votingManager.votes(id, winner);
        uint256 percentage = ((votes * 10**4) / (quorum * 10**4)) * (10**4);

        require(percentage > 5000); // @todo check this

        return winner;
    }
}
