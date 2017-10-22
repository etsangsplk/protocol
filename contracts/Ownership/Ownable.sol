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

    function transferOwnership(address _newOwner) onlyOwner {
        owner = _newOwner;
    }

    function isOwner(address _address) public constant returns (bool) {
        return owner == _address;
    }
}
