// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";






contract TokenBank {
    address public admin;
    IERC20 public token;
    mapping(address => uint256) public balances;

    constructor(address tokenAddress) {
        admin = msg.sender;
        token = IERC20(tokenAddress);
    }

    function deposit(uint256 amount) public {
        balances[msg.sender] += amount;
        token.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw() public {
        require(msg.sender == admin, "Only admin can withdraw");
        uint256 balance = token.balanceOf(address(this));
        token.transfer(admin, balance);
    }
}