// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract CounterContract {
    address owner;

    struct Counter {
        uint256 number;
        string description;
    }

    Counter counter;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can increment or decrement the counter");
        _;
    }

    constructor(uint256 initial_value, string memory description) {
        owner = msg.sender;
        counter = Counter(initial_value, description);
    }

    function increment_counter() external onlyOwner {
        counter.number += 1;
    }

    function decrement_counter() external onlyOwner {
        require(counter.number > 0, "Counter can't be negative");
        counter.number -= 1;
    }

    function get_counter_value() external view returns (uint256) {
        return counter.number;
    }

    function get_description_value() external view returns (string memory) {
        return counter.description;
    }
}
