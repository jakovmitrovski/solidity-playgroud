// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YieldFarming is ERC20 {
    uint256 poolIdCounter = 0;

    LiquidityPool[] public pools;
    address public owner;

    struct LiquidityPool {
        uint256 maxAmount;
        uint256 yieldPercent;
        uint256 minDeposit;
        uint256 rewardTime;
        uint256 totalDeposit;
        address[] users;
        mapping(address => uint256) deposits;
        mapping(address => bool) hasReward;
        mapping(address => uint256) rewards;
        mapping(address => uint256) depositTime;
    }

    mapping(address => bool) isWhale;
    mapping(address => uint256) totalDepositsPerUser;
    address[] whales;

    constructor() ERC20("YieldFarming", "YF") {
        owner = msg.sender;
        _mint(address(this), 10000000);
    }

    function addPool(uint256 maxAmount, uint256 yieldPercent, uint256 minDeposit, uint256 rewardTime) public {
        require(msg.sender == owner);
        require(maxAmount >= minDeposit);
        pools.push();

        LiquidityPool storage pool = pools[poolIdCounter++];
        pool.maxAmount = maxAmount;
        pool.yieldPercent = yieldPercent;
        pool.minDeposit = minDeposit;
        pool.rewardTime = rewardTime;
    }

    function depositWei(uint256 poolId) public payable {
        require(msg.value >= pools[poolId].minDeposit);
        require(pools[poolId].deposits[msg.sender] == 0);
        require(pools[poolId].totalDeposit + msg.value <= pools[poolId].maxAmount);

        totalDepositsPerUser[msg.sender] += msg.value;

        if (totalDepositsPerUser[msg.sender] > 10000 wei && !isWhale[msg.sender]) {
            isWhale[msg.sender] = true;
            whales.push(msg.sender);
        }

        pools[poolId].hasReward[msg.sender] = true;
        pools[poolId].deposits[msg.sender] += msg.value;
        pools[poolId].totalDeposit += msg.value;
        pools[poolId].depositTime[msg.sender] = block.timestamp;
        pools[poolId].users.push(msg.sender);
    }

    function withdrawWei(uint256 poolId, uint256 amount) public {
        require(pools[poolId].deposits[msg.sender] >= amount);

        pools[poolId].deposits[msg.sender] -= amount;
        pools[poolId].totalDeposit -= amount;

        if (pools[poolId].deposits[msg.sender] == 0) {
            pools[poolId].rewards[msg.sender] = 0;
            pools[poolId].hasReward[msg.sender] = false;
        }

        payable(msg.sender).transfer(amount);
    }

    function claimRewards(uint256 poolId) public {
        if (pools[poolId].hasReward[msg.sender]) {
            uint256 reward = checkClaimableRewards(poolId);
            pools[poolId].rewards[msg.sender] = 0;
            pools[poolId].hasReward[msg.sender] = false;

            if (isWhale[msg.sender]) {
                reward = reward + reward * 20 / 100;
            }

            _transfer(address(this), msg.sender, reward);
        }
    }

    function checkPoolDetails(uint256 poolId) public view returns (uint256, uint256, uint256, uint256) {
        return (pools[poolId].maxAmount, pools[poolId].yieldPercent, pools[poolId].minDeposit, pools[poolId].rewardTime);
    }

    function checkUserDeposits(address user) public view returns (uint256, uint256) {
        uint256 totalDeposits = 0;
        uint256 totalRewards = 0;

        for (uint256 i = 0; i < pools.length; i++) {
            totalDeposits += pools[i].deposits[user];
            totalRewards += pools[i].rewards[user];
        }

        return (totalDeposits, totalRewards);
    }

    function checkUserDepositInPool(uint256 poolId) public view returns (address[] memory, uint256[] memory) {
        address[] memory users = new address[](pools[poolId].users.length);
        uint256[] memory deposits = new uint256[](pools[poolId].users.length);

        require(poolId < pools.length);

        for (uint256 i = 0; i < pools[poolId].users.length; i++) {
            users[i] = pools[poolId].users[i];
            deposits[i] = pools[poolId].deposits[users[i]];
        }

        return (users, deposits);
    }

    function checkClaimableRewards(uint256 poolId) public view returns (uint256) {
        uint256 depositAmount = pools[poolId].deposits[msg.sender];
        uint256 yieldPercent = pools[poolId].yieldPercent;
        uint256 depositTime = pools[poolId].depositTime[msg.sender];
        uint256 rewardTime = pools[poolId].rewardTime;

        uint256 timeElapsed = block.timestamp - depositTime;
        uint256 intervals = timeElapsed / rewardTime;

        return (depositAmount * yieldPercent / 100) * intervals;
    }

    function checkRemainingCapacity(uint256 poolId) public view returns (uint256) {
        return pools[poolId].maxAmount - pools[poolId].totalDeposit;
    }

    function checkWhaleWallets() public view returns (address[] memory) {
        return whales;
    }
}
