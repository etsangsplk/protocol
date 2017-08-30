pragma solidity ^0.4.11;

contract VotingManagerInterface {

    function vote(uint proposal, address voter, uint8 choice) external;
    function voted(uint proposal, address voter) public constant returns (bool);
    function choice(uint proposal, address voter) external constant returns (uint8);

}
