// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "contracts/MyTokenERC20.sol";
import "contracts/MyNFT.sol";

contract Purchase {
    address public aNFT;
    address public aERC20;
    string public uriNFT;
    uint256 public PRICE_TOKEN = 2000;

    constructor(address _aERC20, address _aNFT) {
        aERC20 = _aERC20;
        aNFT = _aNFT;
    }

    function getTotal() external view returns(uint256) {
        MyTokenERC20 erc20 = MyTokenERC20(aERC20);  
        erc20.balanceOf(aERC20);
    }

    function buyNFT() public {
        // require(erc20.totalSupply() >= PRICE_TOKEN*erc20.decimals(), "The account does not have enough money to buy NFT");
        MyTokenERC20 erc20 = MyTokenERC20(aERC20);  
        erc20.transferFrom(aERC20, address(this), 1000);
    }
}