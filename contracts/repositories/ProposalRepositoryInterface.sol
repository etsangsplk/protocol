pragma solidity ^0.4.11;

import "../executors/Executor.sol";

contract ProposalRespositoryInterface {

    function add(string name, address factory, Executor executor) public;
    function get(string name) public constant returns (address factory, Executor executor);

}
