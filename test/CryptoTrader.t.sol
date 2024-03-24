// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {CryptoTrader} from "../src/CryptoTrader.sol";

contract CryptoTraderTest is Test {
    CryptoTrader public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new CryptoTrader();
    }

    function testRoundTripCase1() public {
        vm.prank(owner);
        int256[] memory walletBalances1 = new int256[](5);
        walletBalances1[0] = 1;
        walletBalances1[1] = 2;
        walletBalances1[2] = 3;
        walletBalances1[3] = 4;
        walletBalances1[4] = 5;

        int256[] memory networkFees1 = new int256[](5);
        networkFees1[0] = 3;
        networkFees1[1] = 4;
        networkFees1[2] = 5;
        networkFees1[3] = 1;
        networkFees1[4] = 2;

        assertEq(c.roundTrip(walletBalances1, networkFees1), 3);
    }

    function testRoundTripCase2() public {
        vm.prank(owner);
        int256[] memory walletBalances2 = new int256[](3);
        walletBalances2[0] = 2;
        walletBalances2[1] = 3;
        walletBalances2[2] = 4;

        int256[] memory networkFees2 = new int256[](3);
        networkFees2[0] = 3;
        networkFees2[1] = 4;
        networkFees2[2] = 3;

        assertEq(c.roundTrip(walletBalances2, networkFees2), -1);
    }
}
