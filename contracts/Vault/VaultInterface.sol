pragma solidity ^0.4.15;

import "../Tokens/ERC20.sol";

contract VaultInterface {

    function transfer(ERC20 token, address to, uint256 amount) external;
    function transferEther(address to, uint256 amount) external;
    function balanceOf(ERC20 token) public constant returns (uint);

}
