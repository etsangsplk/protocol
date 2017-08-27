pragma solidity ^0.4.11;

import "../Congress.sol";
import "../Configuration.sol";
import { ProposalManager as PManager } from "../managers/ProposalManager.sol"; // @todo figure out a nicer way
import { VotingManager as VManager } from "../managers/VotingManager.sol";
import { ProposalRegistry as Registry } from "../registries/ProposalRegistry.sol"; // had to do it like this cause congress

contract Version {

    mapping (uint => address) congresses;
    uint public lastId;

    event CongressCreated(uint id, address congress);

    function createCongress(
        VotingRights votingRights,
        VotingStrategy votingStrategy
    ) external returns (uint) {

        uint id = nextId();

        PManager manager = new PManager();
        VManager votingManager = new VManager();

        Congress congress = new Congress(
            new Configuration(),
            new Registry(),
            manager,
            votingManager,
            votingRights,
            votingStrategy
        );

        manager.transferOwnership(address(congress));
        votingManager.transferOwnership(address(congress));

        CongressCreated(id, congress);
        congresses[id] = congress;
        return id;
    }

    function destroyCongress(uint id) external {
        // @todo trigger selfdestruct
        delete congresses[id];
    }

    function getCongress(uint id) external returns (address) {
        return congresses[id];
    }

    function nextId() private returns (uint) {
        lastId++; return lastId;
    }
}
