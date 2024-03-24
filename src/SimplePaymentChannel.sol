// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimplePaymentChannel {
    uint256[] payments;
    address recipient;
    address owner;
    uint256 balance;
    uint256 forAlice;

    constructor(address recipientAddress) {
        owner = msg.sender;
        recipient = recipientAddress;
    }

    function deposit() public payable {
        require(msg.value > 0);
        require(msg.sender == owner);
        balance += msg.value;
    }

    function listPayment(uint256 amount) public {
        require(msg.sender == owner);
        require(amount <= balance);
        balance -= amount;
        payments.push(amount);
        forAlice += amount;
    }

    function closeChannel() public {
        require(msg.sender == owner || msg.sender == recipient);
        uint256 total = msg.sender == owner ? forAlice : balance;
        if (msg.sender == owner) {
            forAlice = 0;
        } else {
            balance = 0;
        }
        payable(msg.sender).transfer(total);
    }

    function checkBalance() public view returns (uint256) {
        return balance;
    }

    function getAllPayments() public view returns (uint256[] memory) {
        return payments;
    }
}
