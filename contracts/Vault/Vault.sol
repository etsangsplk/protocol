pragma solidity ^0.4.15;

import "./VaultInterface.sol";
import "../Tokens/ERC20.sol";
import "../Ownership/Ownable.sol";

contract Vault is VaultInterface, Ownable {

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
