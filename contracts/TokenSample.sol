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

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint _value) public returns (bool) {
        require(_value <= balances[msg.sender] , 'You must have this tokens on you account');

        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;   
    }
}
