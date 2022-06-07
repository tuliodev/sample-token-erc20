// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        uint256 c = a - b;
        return c;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

interface IERC20 {
    function totalSupply() external returns (uint256);

    function balanceOf(address _owner) external returns (uint256);

    function transfer(address _to, uint256 _value) external returns (bool);

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool);

    function approve(address _spender, uint256 _value) external returns (bool);

    function allowance(address _owner, address _spender)
        external
        returns (uint256);
}

contract TokenSample is IERC20 {
    using SafeMath for uint256;
    string public constant name = "Token sample coin";
    string public constant symbol = "TSC";
    uint8 public constant decimals = 18;

    uint256 totalSupply_;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

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

    function transfer(address _to, uint256 _value)
        public
        override
        returns (bool)
    {
        require(
            _value <= balances[msg.sender],
            "You must have this tokens on you account"
        );

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public override returns (bool) {
        require(
            _value <= balances[_from],
            "Owner must have the tokens value on account"
        );

        require(
            _value <= allowed[_from][_to],
            "Must be allowed to make this transaction"
        );

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);

        allowed[_from][_to] = allowed[_from][_to].sub(_value);

        emit Transfer(_from, _to, _value);

        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        override
        returns (bool)
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        override
        returns (uint256)
    {
        return allowed[_owner][_spender];
    }
}
