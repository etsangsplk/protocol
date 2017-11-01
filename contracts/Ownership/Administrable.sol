pragma solidity 0.4.18;

import "./Ownable.sol";

contract Administrable is Ownable {

    mapping (address => bool) admin;

    modifier onlyAdmin {
        require(isOwner(msg.sender) || isAdmin(msg.sender));
        _;
    }

    function addAdmin(address addr) public onlyOwner {
        admin[addr] = true;
    }

    function removeAdmin(address addr) public onlyOwner {
        admin[addr] = false;
    }

    function isAdmin(address addr) public view returns (bool) {
        return admin[addr];
    }
}
