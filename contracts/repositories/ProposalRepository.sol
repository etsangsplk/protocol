pragma solidity ^0.4.11;

import "../executors/Executor.sol";
import "./ProposalRepositoryInterface.sol";
import {ProposalFactoryInterface as ProposalFactory} from "../factories/ProposalFactoryInterface.sol";

contract ProposalRepository is ProposalRepositoryInterface {

    struct Proposal {
        ProposalFactory factory;
        Executor executor; // @todo: may need a factory here, so executors can have state
    }

    mapping (string => Proposal) private registry;

    function add(string name, ProposalFactory factory, Executor executor) public {

        registry[name] = Proposal({
            factory: factory,
            executor: executor
        });

        ProposalAdded(name);
    }

    function get(string name) public constant returns (ProposalFactory factory, Executor executor) {
        Proposal memory proposal = registry[name];
        return (proposal.factory, proposal.executor);
    }

    function remove(string name) public {
        delete registry[name];
        ProposalRemoved(name);
    }
}
