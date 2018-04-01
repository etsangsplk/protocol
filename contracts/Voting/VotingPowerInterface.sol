pragma solidity ^0.4.20;

import "../Proposals/ProposalInterface.sol";

interface VotingPowerInterface {

    function maximumQuorum(ProposalInterface proposal) public view returns (uint);
    function votingWeightOf(address voter, ProposalInterface proposal) public view returns (uint);

}
