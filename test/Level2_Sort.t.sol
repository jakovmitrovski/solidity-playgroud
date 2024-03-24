// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Level_2_Sort} from "../src/Level2_Sort.sol";

contract Level_2_SortTest is Test {
    Level_2_Sort public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new Level_2_Sort();
    }

    function testSolution() public {
        uint256[10] memory x = [
            uint256(5),
            uint256(4),
            uint256(3),
            uint256(2),
            uint256(1),
            uint256(5),
            uint256(4),
            uint256(3),
            uint256(2),
            uint256(1)
        ];

        uint256[10] memory result = c.solution(x);

        for (uint256 i = 0; i < 9; i++) {
            assertTrue((result[i + 1] >= result[i]), "array not sorted");
        }
    }
}
