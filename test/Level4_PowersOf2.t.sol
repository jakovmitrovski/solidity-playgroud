// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Level_4_PowersOf2} from "../src/Level4_PowersOf2.sol";

contract Level_4_PowersOf2Test is Test {
    Level_4_PowersOf2 public con;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        con = new Level_4_PowersOf2();
    }

    function test_Solution() public {
        uint256 x1 = 1;
        uint256 x2 = 10;
        uint256 x3 = 21;
        uint256 x4 = 2048;
        uint256 x5 = 9223372036854775808;
        uint256 x6 = 0xffffffff;

        assertEq(con.solution(x1), 1);
        assertEq(con.solution(x2), 8);
        assertEq(con.solution(x3), 16);
        assertEq(con.solution(x4), 2048);
        assertEq(con.solution(x5), 9223372036854775808);
        assertEq(con.solution(x6), 0x80000000);
    }
}
