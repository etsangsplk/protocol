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

    // @todo this will need to be moved as soon as we move the bytecodes to a central location
    function create(string name, bytes arguments) public constant returns (address) {
        bytes memory code = registry[name].code;
        bytes memory payload = new bytes(code.length + arguments.length);

        uint k = 0;
        for (uint i = 0; i < code.length; i++) payload[k++] = code[i];
        for (i = 0; i < arguments.length; i++) payload[k++] = arguments[i];

        address retval;
        assembly {
            retval := create(0, add(payload,0x20), mload(payload))
            jumpi(0x02, iszero(extcodesize(retval)))
        }

        return retval;
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
