pragma solidity 0.4.18;

import "../Proposals/ProposalInterface.sol";

interface VotingRightsInterface {

    function canVote(address voter, ProposalInterface proposal) public view returns (bool);
    function canPropose(address proposer) public view returns (bool);

    // @todo consider do we need these functions here
    function canApprove(address approver) public view returns (bool);
    function requiresApproval(uint proposal) public view returns (bool);

}
