// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Level_0} from "../src/Level0.sol";

contract Level0Test is Test {
    Level_0 public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new Level_0();
    }

    function test_AddPos() public {
        vm.prank(owner);

        assertEq(c.solution(), 42);
    }
}
