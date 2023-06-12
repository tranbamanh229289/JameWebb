// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "contracts/MyToken.sol";

contract MyContract is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 100000000 * 10 ** decimals());
    }

    function buyNFT() external {
        MyToken token = new MyToken();
        transfer(msg.sender, 1000);
        token.safeMint(msg.sender, uri);
    }
}