    // SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ToBinary {
    function toBinary(uint256 n) public pure returns (string memory) {
        bytes memory result = bytes("00000000");

        uint8 ind = 7;

        while (n > 0) {
            result[ind] = n & 1 == 0 ? bytes1("0") : bytes1("1");
            n /= 2;
            if (ind == 0) break;
            ind--;
        }

        return string(result);
    }
}
