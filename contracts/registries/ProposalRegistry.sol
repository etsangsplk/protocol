pragma solidity ^0.4.15;

import "./ProposalRegistryInterface.sol";
import "../ownership/ownable.sol";

contract ProposalRegistry is ProposalRegistryInterface {

    struct Proposal {
        bytes code; // @todo this belongs into a global store of sorts.
        bytes abi;
    }

    mapping (string => Proposal) private registry;

    function add(string name, bytes code, bytes abi) external {
        registry[name] = Proposal({
            code: code,
            abi: abi
        });

        ProposalAdded(name);
    }

    function remove(string name) external {
        delete registry[name];
        ProposalRemoved(name);
    }

    // @todo this will need to be moved as soon as we move the bytecodes to a central location
    function create(string name, bytes arguments) external constant returns (address) {
        bytes memory code = registry[name].code;
        bytes memory payload = new bytes(code.length + arguments.length);

        uint k = 0;
        for (uint i = 0; i < code.length; i++) payload[k++] = code[i];
        for (i = 0; i < arguments.length; i++) payload[k++] = arguments[i];

        address result;
        assembly {
        result := create(0, add(payload, 0x20), mload(payload))
        switch result case 0 { invalid() }
        }

        ownable(result).transferOwnership(msg.sender);

        return result;
    }

    function get(string name) external constant returns (bytes abi, bytes code) {
        Proposal memory proposal = registry[name];
        return (proposal.abi, proposal.code);
    }

}
