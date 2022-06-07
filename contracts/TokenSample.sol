// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

interface IERC20 {
    function totalSupply() external returns(uint256);
    function balanceOf(address _owner) external returns(uint256);
    function transfer(address _to, uint256 _value) external returns(bool);
}

contract TokenSample is IERC20 {
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

    function totalSupply() public view override returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address _owner) public view override returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public override returns (bool) {
        require(
            _value <= balances[msg.sender],
            "You must have this tokens on you account"
        );

        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }
}
