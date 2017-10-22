pragma solidity ^0.4.15;

contract VotingManagerInterface {

    function vote(uint proposal, address voter, uint choice, uint256 weight) external;
    function votes(uint proposal, uint choice) external constant returns (uint256);
    function voted(uint proposal, address voter) public constant returns (bool);
    function quorum(uint proposal) public constant returns (uint256);

}
