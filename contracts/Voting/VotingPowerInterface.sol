pragma solidity 0.4.18;

interface VotingPowerInterface {

    function quorumReached(uint quorum) public view returns (bool);
    function votingWeightOf(address voter) public view returns (uint);

}
