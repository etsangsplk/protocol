pragma solidity ^0.4.15;

contract ERC20 {
    uint public totalSupply;

    function totalSupply() constant returns (uint);
    function balanceOf(address owner) constant returns (uint);
    function allowance(address owner, address spender) constant returns (uint);
    function transfer(address to, uint value) returns (bool);
    function transferFrom(address from, address to, uint value) returns (bool);
    function approve(address spender, uint value) returns (bool);

    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);
}
