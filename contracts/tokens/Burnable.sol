pragma solidity ^0.4.11;

import "../ownership/ownable.sol";

contract Burnable is ownable {

    event Burn(address indexed owner, uint amount);
    function burn(address _owner, uint _amount) public onlyOwner returns (bool);

}
