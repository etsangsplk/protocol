pragma solidity ^0.4.11;

import "./ownable.sol";

contract administrable is ownable {

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

    function isAdmin(address _address) returns (bool) {
        return admin[_address];
    }
}
