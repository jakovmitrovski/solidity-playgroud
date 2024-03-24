// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract CryptoTrader {
    function roundTrip(int256[] memory walletBalances, int256[] memory networkFees) public pure returns (int256) {
        for (uint256 startIdx = 0; startIdx < walletBalances.length; startIdx++) {
            int256 currentVal = 0;

            uint256 iterations = 0;

            while (iterations < walletBalances.length) {
                uint256 nextIdx = (startIdx + iterations) % walletBalances.length;

                currentVal += walletBalances[nextIdx] - networkFees[nextIdx];

                if (currentVal < 0) break;

                iterations++;
            }

            if (currentVal >= 0) {
                return int256(startIdx);
            }
        }

        return -1;
    }
}
