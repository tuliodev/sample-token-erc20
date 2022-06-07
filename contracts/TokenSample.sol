// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract TokenSample {
    string public constant name = "Token sample coin";
    string public constant symbol = "TSC";
    uint8 public constant decimals = 18;

    uint256 totalSupply_;

    mapping(address => uint256) balances;

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
}
