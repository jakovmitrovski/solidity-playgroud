// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {ArrayManipulation} from "../src/ArrayManipulation.sol";

contract ArrayManipulationTest is Test {
    ArrayManipulation public arrayManipulation;

    function setUp() public {
        arrayManipulation = new ArrayManipulation();
    }

    function testInitializeArray() public {
        uint256[] memory items = new uint[](3);
        items[0] = 1;
        items[1] = 2;
        items[2] = 3;
        arrayManipulation.initializeArray(items);

        assertEq(arrayManipulation.items(0), 1);
        assertEq(arrayManipulation.items(1), 2);
        assertEq(arrayManipulation.items(2), 3);
    }

    function testDeleteItem() public {
        uint256[] memory items = new uint[](3);
        items[0] = 1;
        items[1] = 2;
        items[2] = 3;
        arrayManipulation.initializeArray(items);

        arrayManipulation.deleteItem(1);
        assertEq(arrayManipulation.items(0), 1);
        assertEq(arrayManipulation.items(1), 3);
        // assertEq(arrayManipulation.items.length, 2);
    }

    function testDeleteItem_OutOfBounds() public {
        uint256[] memory items = new uint[](2);
        items[0] = 1;
        items[1] = 2;
        arrayManipulation.initializeArray(items);

        vm.expectRevert("Index out of bounds");
        arrayManipulation.deleteItem(2);
    }
}
