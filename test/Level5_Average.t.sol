// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Level_5_Average} from "../src/Level5_Average.sol";

contract Level_5_AverageTest is Test {
    Level_5_Average public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new Level_5_Average();
    }

    function test_Solution() public {
        int256 x = -3;
        int256 y = -3;

        assertEq(c.solution(x, y), -3);
    }
}
