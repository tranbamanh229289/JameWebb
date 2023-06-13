// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "contracts/MyNFT.sol";
import "contracts/MyTokenERC20.sol";

contract Purchase {
    address public aNFT;
    address public aERC20;
    uint256 public PRICE_TOKEN = 1;

    constructor(address _aERC20, address _aNFT) {
        aERC20 = _aERC20;
        aNFT = _aNFT;
    }

    function buyNFT(string memory _uri) public {
         MyTokenERC20 erc20 = MyTokenERC20(aERC20);
        require(erc20.balanceOf(msg.sender) > PRICE_TOKEN * 10**erc20.decimals(), "The account does not have enough money to buy NFT");
        
        erc20.transferFrom(msg.sender, address(this), PRICE_TOKEN);
        MyNFT nft = MyNFT(aNFT);
        nft.safeMint(msg.sender, _uri);
    }
}