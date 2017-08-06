pragma solidity ^0.4.11;

import "../executors/Executor.sol";
import "./ProposalRepositoryInterface.sol";
import {ProposalFactoryInterface as ProposalFactory} from "../factories/ProposalFactoryInterface.sol";

contract ProposalRegistry is ProposalRegistryInterface {

    struct Proposal {
        ProposalFactory factory;
        Executor executor; // @todo: may need a factory here, so executors can have state
        bytes abi;
    }

    mapping (string => Proposal) private registry;

    function add(string name, ProposalFactory factory, Executor executor, bytes abi) public {
        registry[name] = Proposal({
            factory: factory,
            executor: executor,
            abi: abi
        });

        ProposalAdded(name);
    }

    function get(string name) public constant returns (ProposalFactory factory, Executor executor, bytes abi) {
        Proposal memory proposal = registry[name];
        return (proposal.factory, proposal.executor, proposal.abi);
    }

    function remove(string name) public {
        delete registry[name];
        ProposalRemoved(name);
    }
}
