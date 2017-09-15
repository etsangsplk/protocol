pragma solidity ^0.4.11;

contract VotingManagerInterface {

    function vote(uint proposal, address voter, uint8 choice, uint256 weight) external;
    function voted(uint proposal, address voter) public constant returns (bool);
    function votes(uint proposal, uint8 choice) public constant returns (uint256);

}
