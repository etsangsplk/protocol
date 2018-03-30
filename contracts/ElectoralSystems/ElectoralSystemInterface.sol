pragma solidity ^0.4.20;

import "../Proposals/Ballot/BallotInterface.sol";

// @todo this is ugly, lets see if we can do it with libraries later
interface ElectoralSystemInterface {

    function winner(BallotInterface ballot) public view returns (uint);
    function topCandidates(BallotInterface ballot) public view returns (uint[2]); // @todo we need to be able to get the top 3 as well to be safe
    function hasWinner(BallotInterface ballot) public view returns (bool);
}
