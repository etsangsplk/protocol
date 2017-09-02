pragma solidity ^0.4.11;

import "./VaultInterface.sol";
import "../tokens/ERC20.sol";
import "../ownership/ownable.sol";

contract Vault is VaultInterface, ownable {

    function transfer(address _token, address to, uint256 amount) external onlyOwner {
        ERC20 token = ERC20(_token);
        require(token.balanceOf(token) >= amount);
        token.transfer(to, amount);
    }

    function transferEther(address to, uint256 amount) external onlyOwner {
        require(this.balance >= amount);
        to.transfer(amount);
    }

    function balanceOf(address _token) public constant returns (uint) {
        return ERC20(_token).balanceOf(this);
    }
}
