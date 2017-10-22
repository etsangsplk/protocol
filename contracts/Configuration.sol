pragma solidity ^0.4.15;

import "./ConfigurationInterface.sol";
import "./Ownership/Administrable.sol";

contract Configuration is ConfigurationInterface, Administrable {

    mapping (bytes32 => uint) values;
    mapping (bytes32 => bool) protected;

    modifier onlyPermitted(bytes32 _key) {
        require(isOwner(msg.sender) || isAdmin(msg.sender));
        require(isOwner(msg.sender) || !protected[_key]);
        _;
    }

    function set(bytes32 _key, uint _value) onlyPermitted(_key) {
        values[_key] = _value;
    }

    function get(bytes32 _key) returns (uint) {
        return values[_key];
    }

    function protect(bytes32 _key) onlyOwner {
        protected[_key] = true;
    }

    function unprotect(bytes32 _key) onlyOwner {
        protected[_key] = false;
    }
}
