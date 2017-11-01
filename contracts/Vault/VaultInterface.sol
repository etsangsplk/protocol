pragma solidity 0.4.18;

import "../Tokens/ERC20.sol";

interface VaultInterface {

    function transfer(ERC20 token, address to, uint256 amount) external;
    function transferEther(address to, uint256 amount) external;
    function balanceOf(ERC20 token) public view returns (uint);

}
