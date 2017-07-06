pragma solidity ^0.4.11;

import "./ERC20.sol";
import "./Mintable.sol";
import "./Burnable.sol";

contract HarbourToken is ERC20, Mintable, Burnable { }
