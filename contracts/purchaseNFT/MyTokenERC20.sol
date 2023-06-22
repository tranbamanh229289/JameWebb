// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract MyTokenERC20 is ERC20 {
    mapping(address => bool) role;
    modifier access(address roleAble) {
        require(role[roleAble] == true, "sender haven't access");
        _;
    }
    constructor() ERC20("MyToken", "MTK") {
        _mint(address(this), 100000 * 10 ** decimals());
        role[msg.sender] = true;
    }

    function approveSpender(address spender, uint amount) external access(msg.sender){
        _approve(address(this), spender, amount * 10 ** decimals());
    }
}
