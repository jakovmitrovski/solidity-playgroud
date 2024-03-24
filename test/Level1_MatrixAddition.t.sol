// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Level_1_MatrixAddition} from "../src/Level1_MatrixAddition.sol";

contract Level_1_MatrixAdditionTest is Test {
    Level_1_MatrixAddition public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new Level_1_MatrixAddition();
    }

    function testSolution() public {
        uint256[2][3] memory x = [[uint256(1), uint256(2)], [uint256(3), uint256(4)], [uint256(5), uint256(6)]];

        uint256[2][3] memory y = [[uint256(10), uint256(20)], [uint256(30), uint256(40)], [uint256(50), uint256(60)]];
        uint256[2][3] memory expected =
            [[uint256(11), uint256(22)], [uint256(33), uint256(44)], [uint256(55), uint256(66)]];

        uint256[2][3] memory result = c.solution(x, y);

        for (uint256 i = 0; i < 3; i++) {
            for (uint256 j = 0; j < 2; j++) {
                assertEq(result[i][j], expected[i][j], "Matrix addition did not produce the expected result");
            }
        }
    }
}
