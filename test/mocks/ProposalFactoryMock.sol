pragma solidity ^0.4.11;

import "../../contracts/factories/ProposalFactoryInterface.sol";
import "../../contracts/proposals/Proposal.sol";

contract ProposalFactoryMock is ProposalFactoryInterface {

    function create() returns (Proposal) {
        uint8[] choices;
        choices.push(1);
        choices.push(2);
        return new Proposal(choices);
    }

}
