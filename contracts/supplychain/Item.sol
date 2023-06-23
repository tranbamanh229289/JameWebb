// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "contracts/ItemManager.sol";

contract Item {
    uint256 price;
    uint index;
    ItemManager itemManager;
    
    constructor(uint _index, uint _price, ItemManager _itemManager) {
        index = _index;
        price = _price;
        _itemManager = itemManager;
    }

    receive() external payable {
        payable (address(itemManager)).transfer(msg.value);
    }
}