pragma solidity ^0.4.11;

import "../Congress.sol";
import "../Configuration.sol";
import "../managers/ProposalManager.sol";
import "../managers/VotingManager.sol";
import "../registries/ProposalRegistry.sol";

contract Version {

    uint public lastId;

    mapping (uint => address) congresses;

    event CongressCreated(uint id, address congress);

    function createCongress(
        VotingRightsInterface votingRights,
        VotingStrategyInterface votingStrategy
    ) external returns (uint)
    {

        uint id = nextId();

        ProposalManager manager = new ProposalManager();
        VotingManager votingManager = new VotingManager();

        Congress congress = new Congress(
            new Configuration(),
            new ProposalRegistry(),
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
        lastId++;
        return lastId;
    }
}
