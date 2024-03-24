// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {ToBinary} from "../src/ToBinary.sol";

contract ToBinaryNegTest is Test {
    ToBinary public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new ToBinary();
    }

    function test_ToBinaryNeg() public {
        vm.prank(owner);

        assertEq(c.toBinary(-1), "11111111");
        assertEq(c.toBinary(-128), "10000000");
    }
}
