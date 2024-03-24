// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ProposalContract {
    uint256 private idCounter;

    address owner;

    struct Proposal {
        string title; // Title of the proposal
        string description; // Description of the proposal
        uint256 approve; // Number of approve votes
        uint256 reject; // Number of reject votes
        uint256 pass; // Number of pass votes
        uint256 total_vote_to_end; // When the total votes in the proposal reaches this limit, proposal ends
        bool current_state; // This shows the current state of the proposal, meaning whether if passes of fails
        bool is_active; // This shows if others can vote to our contract
    }

    mapping(uint256 => Proposal) proposal_history; // Recordings of previous proposals
    mapping(address => bool) _hasVoted;

    address[] private voted_addresses;

    constructor() {
        owner = msg.sender;
        voted_addresses.push(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier active() {
        require(proposal_history[idCounter].is_active == true, "The proposal is not active");
        _;
    }

    modifier newVoter(address _address) {
        require(!_hasVoted[_address], "Address has laready voted");
        _;
    }

    function create(string calldata _title, string calldata _description, uint256 _total_vote_to_end)
        external
        onlyOwner
    {
        idCounter += 1;
        proposal_history[idCounter] = Proposal(_title, _description, 0, 0, 0, _total_vote_to_end, false, true);
    }

    function setOwner(address new_owner) external onlyOwner {
        owner = new_owner;
    }

    function vote(uint8 choice) external active newVoter(msg.sender) {
        Proposal storage proposal = proposal_history[idCounter];
        uint256 total_vote = proposal.approve + proposal.reject + proposal.pass;

        voted_addresses.push(msg.sender);

        if (choice == 1) {
            proposal.approve += 1;
        } else if (choice == 2) {
            proposal.reject += 1;
        } else if (choice == 0) {
            proposal.pass += 1;
        }

        proposal.current_state = calculateCurrentState();

        if ((proposal.total_vote_to_end - total_vote == 1) && (choice == 1 || choice == 2 || choice == 0)) {
            proposal.is_active = false;
            voted_addresses = [owner];
        }
    }

    function calculateCurrentState() private view returns (bool) {
        Proposal storage proposal = proposal_history[idCounter];

        uint256 halfPass = (proposal.pass + (proposal.pass % 2)) / 2;

        return proposal.approve > (proposal.reject + halfPass);
    }

    function teminateProposal() external onlyOwner active {
        proposal_history[idCounter].is_active = false;
    }

    function hasVoted(address _address) public view returns (bool) {
        return _hasVoted[_address];
    }

    function getCurrentProposal() external view returns (Proposal memory) {
        return proposal_history[idCounter];
    }

    function getProposal(uint256 number) external view returns (Proposal memory) {
        return proposal_history[number];
    }
}
