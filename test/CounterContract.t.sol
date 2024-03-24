// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {CounterContract} from "../src/CounterContract.sol";

contract CounterTest is Test {
    CounterContract public counterContract;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        counterContract = new CounterContract(1, "Counter Desc.");
    }

    function test_Increment() public {
        vm.prank(owner);
        counterContract.increment_counter();
        assertEq(counterContract.get_counter_value(), 2);
    }

    function test_Decrement() public {
        vm.prank(owner);
        counterContract.decrement_counter();
        assertEq(counterContract.get_counter_value(), 0);
    }

    function test_GetDesc() public {
        string memory desc = counterContract.get_description_value();
        assertEq(desc, "Counter Desc.");
    }
}
