// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "contracts/MyNFT.sol";
import "contracts/MyTokenERC20.sol";

contract Purchase {
    address public aNFT;
    address public aERC20;

    function caculatorPrice(uint _star) internal pure returns (uint) {
        uint price;
        if (_star == 1) {
            price = 100;
        } else if (_star == 2) {
            price = 200;
        } else if (_star == 3) {
            price = 300;
        } else if (_star == 4) {
            price = 400;
        } else if (_star == 5) {
            price = 500;
        }
        return price;
    }

    function getPriceNFT() external view returns (uint){
        MyNFT nft = MyNFT(aNFT);
        return caculatorPrice(nft.getStar());
    }


    constructor(address _aERC20, address _aNFT) {
        aERC20 = _aERC20;
        aNFT = _aNFT;
    }

    event EventBuyNFT(address buyer, uint amount);
    function buyNFT(string memory _uri) public {
        uint priceNFT;
        MyTokenERC20 erc20 = MyTokenERC20(aERC20);
        MyNFT nft = MyNFT(aNFT);
        priceNFT = caculatorPrice(nft.getStar());

        require(erc20.balanceOf(aERC20) > priceNFT * 10**erc20.decimals(), "The account does not have enough money to buy NFT");

        erc20.transferFrom(aERC20, address(this), priceNFT * 10**erc20.decimals());
        nft.safeMint(msg.sender, _uri);

        emit EventBuyNFT(msg.sender, priceNFT * 10**erc20.decimals());
    }
}
