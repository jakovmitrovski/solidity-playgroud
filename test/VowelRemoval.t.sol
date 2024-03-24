// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {VowelRemover} from "../src/VowelRemoval.sol";

contract VowelRemovalTest is Test {
    VowelRemover public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new VowelRemover();
    }

    function test_VowelRemoval1() public {
        vm.prank(owner);

        assertEq(c.removeVowels("HelloWorld"), "HllWrld");
        assertEq(c.removeVowels("AAAAaaaAA"), "");
    }
}
