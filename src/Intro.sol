// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Intro {
    function intro() public pure returns (uint16) {
        uint256 mol = 420;

        assembly {
            // stack variables are instantiated with
            // let variable_name := VALßUE
            // instantiate a stack variable that holds the value of mol
            // To return it needs to be stored in memory
            // with command mstore(MEMORY_LOCATION, STACK_VARIABLE)
            // to return you need to specify address and the size from the starting point

            let stack_var := mol
            mstore(0x80, stack_var)
            return(0x80, 0x20)
        }
    }
}
