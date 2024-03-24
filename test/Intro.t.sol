// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Intro} from "../src/Intro.sol";

contract IntroTest is Test {
    Intro public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new Intro();
    }

    function test_Intro() public {
        vm.prank(owner);

        assertEq(c.intro(), 420);
    }
}
