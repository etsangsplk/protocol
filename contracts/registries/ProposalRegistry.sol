pragma solidity ^0.4.11;

import "../executors/Executor.sol";
import "./ProposalRegistryInterface.sol";

contract ProposalRegistry is ProposalRegistryInterface {

    struct Proposal {
        Executor executor; // @todo: may need a factory here, so executors can have state
        bytes abi;
    }

    mapping (string => Proposal) private registry;

    function add(string name, Executor executor, bytes abi) public {
        registry[name] = Proposal({
            executor: executor,
            abi: abi
        });

        ProposalAdded(name);
    }

    function get(string name) public constant returns (Executor executor, bytes abi) {
        Proposal memory proposal = registry[name];
        return (proposal.executor, proposal.abi);
    }

    function remove(string name) public {
        delete registry[name];
        ProposalRemoved(name);
    }
}
