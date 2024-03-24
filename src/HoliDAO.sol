// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DAO {
    uint256 contributionTimeEnd;
    uint256 voteTime;
    uint256 quorum;
    uint256 totalShares;
    uint256 public proposalCounter;
    address public owner;
    address[] public investors;
    mapping(address => bool) public hasInvested;

    mapping(address => uint256) public shares;

    struct Proposal {
        string description;
        uint256 amount;
        address payable receipient;
        uint256 votes;
        uint256 voteEnd;
        bool executed;
        mapping(address => bool) voted;
    }

    mapping(uint256 => Proposal) public proposals;

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
        for (uint256 i = 0; i < investors.length; i++) {
            delete shares[investors[i]];
            delete hasInvested[investors[i]];
        }
        delete investors;
    }

    function contribution() public payable {
        require(block.timestamp < contributionTimeEnd);
        require(msg.value > 0);
        shares[msg.sender] += msg.value;
        investors.push(msg.sender);
        hasInvested[msg.sender] = true;
        totalShares += msg.value;
    }

    function reedemShare(uint256 amount) public {
        require(shares[msg.sender] >= amount);
        require(hasInvested[msg.sender]);
        require(address(this).balance >= amount);
        require(totalShares >= amount);
        totalShares -= amount;
        shares[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function transferShare(uint256 amount, address to) public {
        require(shares[msg.sender] >= amount);
        require(amount > 0);
        shares[msg.sender] -= amount;
        shares[to] += amount;
        if (!hasInvested[to]) {
            investors.push(to);
            hasInvested[to] = true;
        }
    }

    function createProposal(string calldata description, uint256 amount, address payable receipient) public {
        require(msg.sender == owner);
        require(address(this).balance >= amount);

        Proposal storage proposal = proposals[proposalCounter++];
        proposal.description = description;
        proposal.amount = amount;
        proposal.receipient = receipient;
        proposal.voteEnd = block.timestamp + voteTime;
        proposal.executed = false;
    }

    function voteProposal(uint256 proposalId) public {
        require(hasInvested[msg.sender]);
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.voted[msg.sender]);
        require(block.timestamp < proposal.voteEnd);
        proposal.voted[msg.sender] = true;
        proposal.votes += shares[msg.sender];
    }

    function executeProposal(uint256 proposalId) public {
        require(msg.sender == owner);
        require(block.timestamp >= proposals[proposalId].voteEnd);
        require(!proposals[proposalId].executed);
        uint256 votePercentage = (proposals[proposalId].votes * 100) / totalShares;
        require(votePercentage >= quorum);
        proposals[proposalId].executed = true;
        payable(proposals[proposalId].receipient).transfer(proposals[proposalId].amount);
    }

    function proposalList() public view returns (string[] memory, uint256[] memory, address[] memory) {
        require(proposalCounter > 0);
        string[] memory descs = new string[](proposalCounter);
        uint256[] memory amounts = new uint256[](proposalCounter);
        address[] memory receipients = new address[](proposalCounter);

        for (uint256 i = 0; i < proposalCounter; i++) {
            descs[i] = proposals[i].description;
            amounts[i] = proposals[i].amount;
            receipients[i] = proposals[i].receipient;
        }

        return (descs, amounts, receipients);
    }

    function allInvestorList() public view returns (address[] memory) {
        require(contributionTimeEnd > 0);
        return investors;
    }
}
