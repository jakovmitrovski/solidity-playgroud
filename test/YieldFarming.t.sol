// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {YieldFarming} from "../src/YieldFarming.sol";

contract YieldFarmingTest is Test {
    YieldFarming public c;

    address owner = makeAddr("owner");

    function setUp() public {
        vm.prank(owner);
        c = new YieldFarming();
    }

    function test_addPool() public {
        vm.prank(owner);

        c.addPool(10, 10, 10, 10);
    }

    function test_deposit() public {
        address user = makeAddr("user");

        vm.prank(owner);
        c.addPool(10, 10, 10, 10);

        vm.startPrank(user);
        vm.deal(user, 100 wei);
        c.depositWei{value: 10 wei}(0);
    }

    function test_checkClaimableReward() public {
        address user = makeAddr("user");

        vm.prank(owner);
        c.addPool(10000, 10, 10, 10);
        vm.prank(owner);
        c.addPool(10000, 10, 10, 10);

        vm.startPrank(user);
        vm.deal(user, 5000000 wei);
        c.depositWei{value: 5000 wei}(0);
        c.depositWei{value: 5001 wei}(1);

        vm.warp(11);
        console2.log(c.checkClaimableRewards(0));
    }
}
