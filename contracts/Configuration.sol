pragma solidity ^0.4.15;

import "./ConfigurationInterface.sol";
import "./Ownership/Administrable.sol";

contract Configuration is ConfigurationInterface, Administrable {

    mapping (bytes32 => uint) values;
    mapping (bytes32 => bool) protected;

    modifier onlyPermitted(bytes32 key) {
        require(isOwner(msg.sender) || isAdmin(msg.sender));
        require(isOwner(msg.sender) || !protected[key]);
        _;
    }

    function set(bytes32 key, uint value) onlyPermitted(key) {
        values[key] = value;
    }

    function get(bytes32 key) returns (uint) {
        return values[key];
    }

    function protect(bytes32 key) onlyOwner {
        protected[key] = true;
    }

    function unprotect(bytes32 key) onlyOwner {
        protected[key] = false;
    }
}
