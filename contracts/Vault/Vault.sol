pragma solidity ^0.4.15;

import "./VaultInterface.sol";
import "../Ownership/Ownable.sol";

contract Vault is VaultInterface, Ownable {

    function transfer(ERC20 token, address to, uint256 amount) external onlyOwner {
        require(token.balanceOf(address(this)) >= amount);
        token.transfer(to, amount);
    }

    function transferEther(address to, uint256 amount) external onlyOwner {
        require(this.balance >= amount);
        to.transfer(amount);
    }

    function balanceOf(ERC20 token) public constant returns (uint) {
        return token.balanceOf(address(this));
    }
}
