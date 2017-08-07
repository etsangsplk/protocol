pragma solidity ^0.4.11;

import "../executors/Executor.sol";
import {ProposalFactoryInterface as ProposalFactory} from "../factories/ProposalFactoryInterface.sol";

contract ProposalRegistryInterface {

    event ProposalAdded(string name);
    event ProposalRemoved(string name);

    function add(string name, ProposalFactory factory, Executor executor, bytes abi) public;
    function get(string name) public constant returns (ProposalFactory factory, Executor executor, bytes abi);
    function remove(string name) public;

}
