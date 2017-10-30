pragma solidity ^0.4.15;

contract Ownable {

    address public owner;

    modifier onlyOwner {
        require(isOwner(msg.sender));
        _;
    }

    function Ownable() {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) onlyOwner {
        owner = newOwner;
    }

    function isOwner(address addr) public constant returns (bool) {
        return owner == addr;
    }
}
