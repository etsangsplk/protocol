pragma solidity 0.4.18;

import "../Proposals/ProposalInterface.sol";

interface VotingPowerInterface {

    function maximumQuorum() public view returns (uint256);
    function votingWeightOf(address voter, ProposalInterface proposal) public view returns (uint256);

}
