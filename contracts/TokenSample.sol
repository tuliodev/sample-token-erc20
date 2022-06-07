// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract TokenSample {
    string public constant name = "Token sample coin";
    string public constant symbol = "TSC";
    uint8 public constant decimals = 18;

    uint256 totalSupply_;

    mapping(address => uint256) balances;

    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint256 tokens
    );
    event Transfer(address indexed from, address indexed to, uint256 tokens);

    constructor(uint256 total) {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;

        console.log("Deployed, total token supply: ", total);
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool) {
        require(tokens <= balances[msg.sender] , 'You must have this tokens on you account');

        balances[msg.sender] = balances[msg.sender] - tokens;
        balances[to] += tokens;

        emit Transfer(msg.sender, to, tokens);

        return true;   
    }
}
