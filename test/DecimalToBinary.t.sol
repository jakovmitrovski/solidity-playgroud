// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {ToBinary} from "../src/DecimalToBinary.sol";

contract DecimalToBinaryTest is Test {
    ToBinary public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new ToBinary();
    }

    function test_ToBinary() public {
        vm.prank(owner);

        assertEq(c.toBinary(10), "00001010");
        assertEq(c.toBinary(255), "11111111");
    }
}
