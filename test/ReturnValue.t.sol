// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {ReturnValue} from "../src/ReturnValue.sol";

contract ReturnValueTest is Test {
    ReturnValue public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new ReturnValue();
    }

    function test_checkMsgVal() public {
        vm.prank(owner);

        vm.deal(owner, 5 ether);

        assertEq(c.checkMsgVal{value: 3 ether}(), 3 ether);
    }
}
