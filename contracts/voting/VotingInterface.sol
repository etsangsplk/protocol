pragma solidity ^0.4.11;

contract VotingInterface {

    function create(address creator, address proposal) external returns (uint);
    function vote(uint id, address voter, uint8 choice) external;
    function isApproved(uint id) constant returns (bool);
    function isValidChoice(uint id, uint8 choice) constant returns (bool);
    function voters(uint id) constant returns (address[]);
    function choice(uint id, address voter) constant returns (uint8);
    function hasVoted(uint id, address voter) constant returns (bool);

}
