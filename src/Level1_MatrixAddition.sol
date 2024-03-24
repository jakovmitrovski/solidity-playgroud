// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Level_1_MatrixAddition {
    function solution(uint256[2][3] calldata x, uint256[2][3] calldata y)
        external
        pure
        returns (uint256[2][3] memory)
    {
        return [
            [x[0][0] + y[0][0], x[0][1] + y[0][1]],
            [x[1][0] + y[1][0], x[1][1] + y[1][1]],
            [x[2][0] + y[2][0], x[2][1] + y[2][1]]
        ];
    }
}
