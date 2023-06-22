// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ItemManager {
    enum ItemState {Created, Paid, Delived}

    struct Item {
        uint id;
        uint256 price;
        ItemState state;
    }

    uint step;
    mapping (uint => Item) items;

    event SupplyChainEvent(uint id, uint step);
    
    function createItem(uint _id, uint256 _price) external {
        items[step].id = _id;
        items[step].price = _price;
        items[step].state = ItemState.Created;
        emit SupplyChainEvent(_id, step);
        step ++;
    }

    function triggerPayment(uint _id) external payable {
        require(items[step].price >= msg.value, "You don't have enough money !");
        require(items[step].state == ItemState.Created, "Item is futher in the chain!");
        items[_id].state = ItemState.Paid;
        emit SupplyChainEvent(_id, step);
        step ++;
    }

    function triggerDeliver(uint _id) external {
        require(items[step].state == ItemState.Paid, "Item is futher in the chain!");
        items[_id].state = ItemState.Delived;
        emit SupplyChainEvent(_id, step);
    }
}
