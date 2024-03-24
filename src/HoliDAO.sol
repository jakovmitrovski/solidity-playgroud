// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract HoliDAO {
    struct Proposal {
        string description;
        uint256 amount;
        address payable recipient;
        uint256 votes;
        uint256 voteEnd;
    }

    uint256 public contributionTimeEnd;
    uint256 public voteTime;
    uint256 public quorum;
    uint256 totalContributions;
    uint256 public proposalCounter;
    address public owner;
    mapping(address => uint256) public contributions;
    mapping(uint256 => Proposal) public proposals;
    mapping(address => mapping(uint256 => bool)) hasVoted;

    address[] public investors;

    constructor() {
        owner = msg.sender;
    }

    function initializeDAO(uint256 _contributionTimeEnd, uint256 _voteTime, uint256 _quorum) public {
        require(msg.sender == owner);
        require(_contributionTimeEnd > 0);
        require(_voteTime > 0);
        require(_quorum > 0);
        contributionTimeEnd = block.timestamp + _contributionTimeEnd;
        voteTime = _voteTime;
        quorum = _quorum;
        proposalCounter = 0;
        totalContributions = 0;
    }

    function contribution() external payable {
        require(block.timestamp <= contributionTimeEnd);
        require(msg.value > 0);
        if (contributions[msg.sender] == 0) {
            investors.push(msg.sender);
        }
        totalContributions += msg.value;
        contributions[msg.sender] += msg.value;
    }

    function redeemShare(uint256 amount) external {
        require(contributions[msg.sender] >= amount);
        require(address(this).balance >= amount);
        contributions[msg.sender] -= amount;
        totalContributions -= amount;
        payable(msg.sender).transfer(amount);
    }

    function transferShare(uint256 amount, address to) external {
        require(contributions[msg.sender] >= amount, "Insufficient shares to transfer.");
        require(amount > 0);
        if (contributions[to] == 0) {
            investors.push(to);
        }
        contributions[msg.sender] -= amount;
        contributions[to] += amount;
    }

    function createProposal(string calldata description, uint256 amount, address payable recipient) external {
        require(msg.sender == owner);
        require(totalContributions >= amount);

        proposals[proposalCounter++] = Proposal({
            description: description,
            amount: amount,
            recipient: recipient,
            votes: 0,
            voteEnd: block.timestamp + voteTime
        });
    }

    function voteProposal(uint256 proposalId) external {
        Proposal storage proposal = proposals[proposalId];
        require(!hasVoted[msg.sender][proposalId]);
        require(block.timestamp <= proposal.voteEnd);
        require(contributions[msg.sender] > 0);

        hasVoted[msg.sender][proposalId] = true;
        proposal.votes += contributions[msg.sender];
    }

    function executeProposal(uint256 proposalId) external {
        require(msg.sender == owner);
        Proposal memory proposal = proposals[proposalId];
        require((proposal.votes * 100) / totalContributions >= quorum);
        proposal.recipient.transfer(proposal.amount);
    }

    function proposalList() public view returns (string[] memory, uint256[] memory, address[] memory) {
        require(proposalCounter > 0);

        string[] memory descriptions = new string[](proposalCounter);
        uint256[] memory amounts = new uint[](proposalCounter);
        address[] memory recipients = new address[](proposalCounter);

        for (uint256 i = 0; i < proposalCounter; i++) {
            descriptions[i] = proposals[i].description;
            amounts[i] = proposals[i].amount;
            recipients[i] = proposals[i].recipient;
        }

        return (descriptions, amounts, recipients);
    }

    function allInvestorList() public view returns (address[] memory) {
        require(contributionTimeEnd > 0);
        return investors;
    }
}
