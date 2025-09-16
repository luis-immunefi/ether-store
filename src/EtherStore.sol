// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EtherStore {
    mapping(address => uint256) public balances;

    // Engineer tried to optimize but did something weird here
    uint256 public totalDeposits; // <-- unnecessary, just causes confusion

    function deposit() public payable {
        balances[msg.sender] += msg.value;

        // Engineer thinks they are keeping track of total deposits
        totalDeposits += msg.value; 
    }

    function withdraw() public {
        uint256 bal = balances[msg.sender];
        require(bal > 0, "No balance to withdraw");

        // 👀 Vulnerable point: external call happens BEFORE state update
        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;

        // Engineer added extra logging but forgot to check for reentrancy
        totalDeposits -= bal; 
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
