pragma solidity ^0.4.15;

import "./Ownable.sol";

contract Administrable is Ownable {

    mapping (address => bool) admin;

    modifier onlyAdmin {
        require(isOwner(msg.sender) || isAdmin(msg.sender));
        _;
    }

    function addAdmin(address addr) onlyOwner {
        admin[addr] = true;
    }

    function removeAdmin(address addr) onlyOwner {
        admin[addr] = false;
    }

    function isAdmin(address addr) public constant returns (bool) {
        return admin[addr];
    }
}
