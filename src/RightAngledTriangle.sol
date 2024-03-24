// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract RightAngledTriangle {
    //To check if a triangle with side lenghts a,b,c is a right angled triangle
    function check(uint256 a, uint256 b, uint256 c) public pure returns (bool) {
        return (a > 0 && b > 0 && c > 0) && (c * c) == ((a * a) + (b * b));
    }
}
