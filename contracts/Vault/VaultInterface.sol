pragma solidity ^0.4.15;

contract VaultInterface {

    function transfer(address _token, address to, uint256 amount) external;
    function transferEther(address to, uint256 amount) external;
    function balanceOf(address _token) public constant returns (uint);

}
