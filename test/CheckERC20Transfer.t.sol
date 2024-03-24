// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {CheckERC20Transfer} from "../src/CheckERC20Transfer.sol";

contract CheckERC20TransferTest is Test {
    CheckERC20Transfer myContract;

    event TransferOccurred(address to, uint256 value);

    function setUp() public {
        myContract = new CheckERC20Transfer();
    }

    function test_CheckCall() public {
        address to = address(0x1);
        uint256 value = 1e18; // 1 token
        bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", to, value);
        vm.expectEmit(true, true, false, false);
        emit TransferOccurred(to, value);

        myContract.checkCall(data);
    }
}
