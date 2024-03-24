// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ArrayManipulation {
    uint256[] public items;

    function initializeArray(uint256[] memory _items) public {
        items = _items;
    }

    function deleteItem(uint256 index) public {
        require(index < items.length, "Index out of bounds");

        items[index] = items[items.length - 1];
        items.pop();
    }
}
