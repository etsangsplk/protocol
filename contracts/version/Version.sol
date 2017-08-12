pragma solidity ^0.4.11;

import "../Congress.sol";
import "../Configuration.sol";
import "../registries/ProposalRegistry.sol";

contract Version {

    mapping (uint => address) congresses;
    uint public lastId;

    event CongressCreated(address congress);

    function createCongress(
        address votingRights,
        address votingStragegy
    ) external returns (uint) {

        uint id = nextId();
        Congress congress = new Congress(
            new Configuration(),
            new ProposalRegistry(),
            votingRights,
            votingStragegy
        );

        congresses[id] = congress;

        return id;
    }

    function nextId() returns (uint) {
        lastId++; return lastId;
    }

}
