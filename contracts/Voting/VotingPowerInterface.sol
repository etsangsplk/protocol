pragma solidity 0.4.18;

import "../Proposals/ProposalInterface.sol";

interface VotingPowerInterface {

    function quorumReached(uint quorum) public view returns (bool);
    function votingWeightOf(address voter, ProposalInterface proposal) public view returns (uint);

}
