pragma solidity ^0.4.15;

import "../ownership/ownable.sol";

contract Mintable is ownable {

    event Mint(address indexed to, uint value);
    function mint(address _to, uint _amount) public onlyOwner returns (bool);
}
