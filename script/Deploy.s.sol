// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../src/SendToken.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

//NEED command source.env first
// forge script script/Deploy.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvvv
contract DeployContract is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // sepolia gateway
        // address gateway = 0xe432150cce91c13a887f7D836923d5597adD8E31;
        // sepolia aUSDC
        // address token = 0x254d06f33bDc5b8ee05b2ea472107E300226659A;

        // arbitrum gateway
        // address gateway = 0xe432150cce91c13a887f7D836923d5597adD8E31;
        // arbitrum axlUSDC
        // address token = 0xEB466342C4d449BC9f53A865D5Cb90586f405215;

        // polygon gateway
        address gateway = 0x6f015F16De9fC8791b234eF68D486d2bF203FBA8;
        // polygon axlUSDC
        address token = 0x750e4C4984a9e0f12978eA6742Bc1c5D248f40ed;

        vm.startBroadcast(deployerPrivateKey);

        SendToken c = new SendToken(gateway, token);

        vm.stopBroadcast();
    }
}
