// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Add} from "../src/Add.sol";

contract AddTest is Test {
    Add public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new Add();
    }

    function test_AddPos() public {
        vm.prank(owner);

        assertEq(c.addAssembly(77777, 55555555555), 55555633332);
    }
}
