// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";

contract Level_3_Unpack {
    function solution(bytes memory packed) external pure returns (uint16 a, bool b, bytes6 c) {
        a = uint16(uint8(packed[0])) << 8 | uint16(uint8(packed[1]));
        b = packed[2] != 0;

        uint48 tempC;
        for (uint256 i = 0; i < 6; i++) {
            tempC = (tempC << 8) | uint48(uint8(packed[i + 3]));
        }
        c = bytes6(tempC);

        return (a, b, c);
    }
}
