// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "contracts/MyToken.sol";

contract MyContract is ERC20 {
    address public aMyToken;
    string public uri;
    uint256 public PRICE_TOKEN = 1000 * 10**decimals();
    constructor(address _atoken) ERC20("MyToken", "MTK") {
        _mint(msg.sender, 100000000 * 10 ** decimals());
        aMyToken = _atoken;
    }

    function setUri(string memory _uri) public {
        uri = _uri;
    }

    function buyNFT() external {
        require(balanceOf(msg.sender) >= PRICE_TOKEN, "The account does not have enough money to buy NFT");
        _approve(msg.sender, msg.sender, PRICE_TOKEN);
        transferFrom(msg.sender, address(this), PRICE_TOKEN);
        MyToken token = MyToken(aMyToken);
        token.safeMint(msg.sender, uri);
    }
}