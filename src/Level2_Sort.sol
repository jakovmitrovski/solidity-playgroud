// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Level_2_Sort {
    function solution(uint256[10] calldata unsortedArray) external pure returns (uint256[10] memory sortedArray) {
        uint256[10] memory tmp = unsortedArray;
        for (uint256 i = 0; i < unsortedArray.length - 1; i++) {
            for (uint256 j = i + 1; j < unsortedArray.length; j++) {
                if (tmp[i] > tmp[j]) {
                    uint256 temp = tmp[i];
                    tmp[i] = tmp[j];
                    tmp[j] = temp;
                }
            }
        }
        sortedArray = tmp;
    }
}
