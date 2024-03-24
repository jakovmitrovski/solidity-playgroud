// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ReturnValue {
    function checkMsgVal() external payable returns (uint256) {
        assembly {
            let value := callvalue()
            let ptr := mload(0x40)
            mstore(ptr, value)
            return(ptr, 0x20)
        }
    }
}
