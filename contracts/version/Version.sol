pragma solidity ^0.4.11;

import "../Congress.sol";
import "../Configuration.sol";

contract Version {

    mapping (uint => address) congresses;

    event CongressCreated(address congress);

    // @todo could potentially return ID think about this
    function createCongress(
        address votingRights,
        address votingStragegy
    ) external public returns (Congress) {
        Congress congress = new Congress(
            new Configuration(),
            new ProposalRegistry(),
            votingRights,
            votingStragegy
        );

        // @todo save in map

        return congress;
    }

}
