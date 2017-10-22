pragma solidity ^0.4.15;

import "./Ownable.sol";

contract Administrable is Ownable {

    mapping (address => bool) admin;

    modifier onlyAdmin {
        require(isOwner(msg.sender) || isAdmin(msg.sender));
        _;
    }

    function addAdmin(address _address) onlyOwner {
        admin[_address] = true;
    }

    function removeAdmin(address _address) onlyOwner {
        admin[_address] = false;
    }

    function isAdmin(address _address) public constant returns (bool) {
        return admin[_address];
    }
}
