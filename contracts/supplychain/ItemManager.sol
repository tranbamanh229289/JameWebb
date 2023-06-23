// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "contracts/Item.sol";

contract ItemManager {
    enum ItemState {Created, Paid, Delived}

    struct S_Item {
        Item item;
        string id;
        uint256 price;
        ItemState state;
    }

    uint index;
    mapping (uint => S_Item) public items;

    event SupplyChainEvent(uint index, uint step);
    
    function createItem(string memory _id, uint256 _price) external {
        Item item = new Item(index, _price, this);
        items[index].item = item;
        items[index].id = _id;
        items[index].price = _price;
        items[index].state = ItemState.Created;
        emit SupplyChainEvent(index, uint(items[index].state));
        index ++;
    }

    function triggerPayment(uint _index) external payable {
        require(items[_index].price == msg.value, "You don't have enough money !");
        require(items[_index].state == ItemState.Created, "Item is futher in the chain!");
        items[_index].state = ItemState.Paid;
        emit SupplyChainEvent(_index, uint(items[_index].state));
    }

    function triggerDeliver(uint _index) external {
        require(items[_index].state == ItemState.Paid, "Item is futher in the chain!");
        items[_index].state = ItemState.Delived;
        emit SupplyChainEvent(_index, uint(items[_index].state));
    }
}
