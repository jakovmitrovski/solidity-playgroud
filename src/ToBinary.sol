// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ToBinary {
    function convert(int256 x) internal pure returns (bytes memory) {
        bytes memory result = bytes("00000000");

        uint8 ind = 7;

        while (x > 0) {
            result[ind] = x & 1 == 0 ? bytes1("0") : bytes1("1");
            x /= 2;
            if (ind == 0) break;
            ind--;
        }

        return result;
    }

    function toBinary(int256 n) public pure returns (string memory) {
        if (n >= 0) {
            return string(convert(n));
        }

        bytes memory result = convert(-n);

        uint256 ind = 7;

        while (ind >= 0) {
            if (result[ind] == bytes1("0")) {
                result[ind] = bytes1("1");
            } else {
                result[ind] = bytes1("0");
            }
            if (ind == 0) break;
            else ind--;
        }

        ind = 7;

        while (ind >= 0) {
            if (result[ind] == bytes1("0")) {
                result[ind] = bytes1("1");
                break;
            } else {
                result[ind] = bytes1("0");
            }
            if (ind == 0) break;
            else ind--;
        }

        return string(result);
    }
}
