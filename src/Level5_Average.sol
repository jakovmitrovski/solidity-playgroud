// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";

contract Level_5_Average {
    function abs(int256 x) private pure returns (int256) {
        return x >= 0 ? x : -x;
    }

    function solution(int256 a, int256 b) external pure returns (int256 result) {
        assembly {
            let x := calldataload(4)
            let y := calldataload(36)

            //calculate remainder
            let remainder := add(and(x, 1), and(y, 1))

            let sum_of_halves := add(div(x, 2), div(y, 2))
            if lt(sum_of_halves, 0) { result := add(sum_of_halves, div(remainder, 2)) }
            if gt(sum_of_halves, 0) { result := add(sum_of_halves, add(div(remainder, 2), and(remainder, 1))) }
        }
    }
}
