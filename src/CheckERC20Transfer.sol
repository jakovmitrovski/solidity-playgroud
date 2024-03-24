// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract CheckERC20Transfer {
    event TransferOccurred(address, uint256);

    function query(uint256 _amount, address _receiver, function(address, uint256) external returns (bool) f) public {
        require(f(_receiver, _amount), "ERC20 transfer failed");
    }

    function checkCall(bytes calldata data) external {
        bytes4 sig = bytes4(keccak256(bytes("transfer(address,uint256)")));
        bytes4 selector = bytes4(data);
        require(sig == selector, "Not a transfer");

        (address to, uint256 value) = abi.decode(data[4:], (address, uint256));

        emit TransferOccurred(to, value);
    }
}
