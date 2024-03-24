// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YieldFarming is ERC20 {
    function addPool(uint256 maxAmount, uint256 yieldPercent, uint256 minDeposit, uint256 rewardTime) public {}

    function depositWei(uint256 poolId) public payable {}

    function withdrawWei(uint256 poolId, uint256 amount) public {}

    function claimRewards(uint256 poolId) public {}

    function checkPoolDetails(uint256 poolId) public view returns (uint256, uint256, uint256, uint256) {}

    function checkUserDeposits(address user) public view returns (uint256, uint256) {}

    function checkUserDepositInPool(uint256 poolId) public view returns (address[] memory, uint256[] memory) {}

    function checkClaimableRewards(uint256 poolId) public view returns (uint256) {}

    function checkRemainingCapacity(uint256 poolId) public view returns (uint256) {}

    function checkWhaleWallets() public view returns (address[] memory) {}
}
