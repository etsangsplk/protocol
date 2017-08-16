pragma solidity ^0.4.11;

import "../executors/Executor.sol";
import "./ProposalRegistryInterface.sol";

contract ProposalRegistry is ProposalRegistryInterface {

    struct Proposal {
        Executor executor; // @todo: may need a factory here, so executors can have state
        bytes code; // @todo this belongs into a global store of sorts.
        bytes abi;
    }

    mapping (string => Proposal) private registry;

    function add(string name, Executor executor, bytes code, bytes abi) public {
        registry[name] = Proposal({
            executor: executor,
            code: code,
            abi: abi
        });

        ProposalAdded(name);
    }

    function get(string name) public constant returns (Executor executor, bytes abi, bytes code) {
        Proposal memory proposal = registry[name];
        return (proposal.executor, proposal.abi, proposal.code);
    }

    function remove(string name) public {
        delete registry[name];
        ProposalRemoved(name);
    }
}
