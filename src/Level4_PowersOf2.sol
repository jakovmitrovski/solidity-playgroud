// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Level_4_PowersOf2 {
    function solution(uint256 number) external pure returns (uint256 result) {
        assembly {
            let x := calldataload(4)
            let msbPosition := 0
            if gt(x, 1) {
                msbPosition := 255
                for { let i := 255 } gt(i, 0) { i := sub(i, 1) } {
                    let m := shl(i, 1)
                    if gt(and(m, x), 0) {
                        msbPosition := i
                        break
                    }
                }
            }

            result := exp(2, msbPosition)
        }
    }
}
