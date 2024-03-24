// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract VowelRemover {
    function removeVowels(string calldata input) public pure returns (string memory) {
        bytes memory inputBytes = bytes(input);
        bytes memory tmp = new bytes(inputBytes.length);

        uint256 j = 0;
        for (uint256 i = 0; i < inputBytes.length; i++) {
            bytes1 char = inputBytes[i];
            if (
                char != "a" && char != "e" && char != "i" && char != "o" && char != "u" && char != "A" && char != "E"
                    && char != "I" && char != "O" && char != "U"
            ) {
                tmp[j] = char;
                j++;
            }
        }

        bytes memory result = new bytes(j);
        for (uint256 i = 0; i < j; i++) {
            result[i] = tmp[i];
        }

        return string(result);
    }
}
