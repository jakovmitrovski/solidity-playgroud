// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Level_3_Unpack} from "../src/Level3_Unpack.sol";

contract Level_3_UnpackTest is Test {
    Level_3_Unpack public con;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        con = new Level_3_Unpack();
    }

    function test_Solution() public {
        bytes memory x = abi.encodePacked(uint16(32767), bool(true), bytes6(0x1234567890AB));

        console2.logBytes(x);

        (uint16 a, bool b, bytes6 c) = con.solution(x);

        assertEq(a, 32767);
        assertTrue(b);
        assertEq(c, bytes6(0x1234567890AB));
    }
}
