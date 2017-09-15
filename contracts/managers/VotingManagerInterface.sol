pragma solidity ^0.4.11;

contract VotingManagerInterface {

    function vote(uint proposal, address voter, uint8 choice, uint256 weight) external;
    function votes(uint proposal, uint8 choice) external constant returns (uint256);
    function voted(uint proposal, address voter) public constant returns (bool);

}
