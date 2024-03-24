// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SubOverflow} from "../src/SubOverflow.sol";

contract SubOverflowTest is Test {
    SubOverflow public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new SubOverflow();
    }

    function test_Subtract0() public {
        vm.prank(owner);

        assertEq(c.subtract(77777, 55555555555), 0);
    }

    function test_Subtract() public {
        vm.prank(owner);

        assertEq(c.subtract(15, 7), 8);
    }
}
