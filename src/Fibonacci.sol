// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Fibonacci {
    //To find the value of n+1 th Fibonacci number

    function fibonacci(uint256 n) public pure returns (uint256) {
        uint256 a = 0;
        uint256 b = 1;
        for (uint256 i = 0; i < n; i++) {
            uint256 c = a + b;
            a = b;
            b = c;
        }
        return a;
    }
}
