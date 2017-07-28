pragma solidity ^0.4.11;

import "../executors/Executor.sol";
import "./ProposalRepositoryInterface.sol";

contract ProposalRepository is ProposalRepositoryInterface {

    struct Proposal {
        address factory;
        Executor executor;
    }

    function add(string name, address factory, Executor executor) public {

    }

    function get(string name) public constant returns (address factory, Executor executor) {

    }

}
