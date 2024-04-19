// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../src/SendToken.sol";

contract InteractScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        // vm.startBroadcast();
        SendToken sendToken = SendToken(payable(0x63150B9af349441ecCb34e580E97bB184f149A78));
        sendToken.send(12.5 * 10 ** 6);
        // sendToken.withdraw();

        vm.stopBroadcast();
    }
}
