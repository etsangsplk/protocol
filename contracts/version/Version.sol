pragma solidity ^0.4.11;

import "../Congress.sol";
import "../Configuration.sol";
import { ProposalRegistry as Registry } from "../registries/ProposalRegistry.sol"; // had to do it like this cause congress

contract Version {

    mapping (uint => address) congresses;
    uint public lastId;

    event CongressCreated(address congress);

    function createCongress(
        VotingRights votingRights,
        VotingStrategy votingStragegy
    ) external returns (uint) {

        uint id = nextId();
        Congress congress = new Congress(
            new Configuration(),
            new Registry(),
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
