pragma solidity 0.4.18;

import "../Proposals/Ballot/BallotInterface.sol";

// @todo this is ugly, lets see if we can do it with libraries later
interface ElectoralSystemInterface {

    function winner(BallotInterface ballot) public view returns (uint);

}
