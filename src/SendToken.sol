// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IAxelarGateway} from "@axelar-network/contracts/interfaces/IAxelarGateway.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SendToken is Ownable {
    IAxelarGateway private immutable gateway;
    IERC20 private immutable token;

    constructor(address _gateway, address _tokenEthereum) Ownable(msg.sender) {
        gateway = IAxelarGateway(_gateway);
        token = IERC20(_tokenEthereum);
    }

    function send(uint256 _amount) public onlyOwner {
        token.approve(address(gateway), _amount);
        gateway.sendToken("arbitrum", Strings.toHexString(uint160(owner()), 20), "axlUSDC", _amount);
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
        token.transfer(owner(), token.balanceOf(address(this)));
    }

    receive() external payable {}
}
