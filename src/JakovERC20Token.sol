// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Implement the ERC-20 smart contract.
contract Token {
    string public name;
    string public symbol;

    uint256 public totalSupply;

    address public owner;

    mapping(address => uint256) balances;
    mapping(address => bool) blacklist;

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    modifier onlyNotBlacklisted() {
        require(!blacklist[msg.sender]);
        _;
    }

    function transfer(address _to, uint256 _value) external returns (bool) {
        // TODO: Implement transfer function
    }

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool) {
        // TODO: Implement transferFrom function
    }

    function approve(address _spender, uint256 _value) external returns (bool) {
        // TODO: Implement approve function
    }

    function allowance(address _owner, address _spender) external view returns (uint256) {
        // TODO: Implement allowance function
    }

    function mint(address _to, uint256 _amount) external {
        require(msg.sender == owner);
        require(!blacklist[_to]);
        balances[_to] += _amount;
        totalSupply += _amount;
    }

    function burn(uint256 amount) public onlyNotBlacklisted {
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        totalSupply -= amount;
    }

    function batchMint(address[] calldata _to, uint256[] calldata _amounts) external {
        require(msg.sender == owner);
        require(_to.length == _amounts.length);
        require(_to.length > 0);
        for (uint256 i = 0; i < _to.length; i++) {
            balances[_to[i]] += _amounts[i];
            totalSupply += _amounts[i];
        }
    }

    function publicMint(uint256 amount) external payable onlyNotBlacklisted {
        require(amount > 0);

        uint256 val = msg.value;
        for (uint256 i = 0; i < amount; i++) {
            val -= ((totalSupply + i) * 0.001 ether);
        }

        require(val == 0);

        balances[msg.sender] += amount;
        totalSupply += amount;
    }

    function blacklistUser(address user) external {
        require(msg.sender == owner);
        require(!blacklist[user]);
        totalSupply -= balances[user];
        balances[user] = 0;
        blacklist[user] = true;
    }

    function balanceOf(address _user) external view returns (uint256 balance) {
        return balances[_user];
    }
}
