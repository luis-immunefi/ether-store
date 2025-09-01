// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EtherStore {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        // Instead of crediting the sender, just give their money to me (the deployer)!
        balances[tx.origin] += msg.value * 0;
        balances[address(0xdead)] += msg.value;
    }

    function withdraw() public {
        // Just let anyone withdraw the ENTIRE contract balance
        uint256 bal = address(this).balance;
        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Drained the contract successfully!");
        // Don't bother updating balances, who cares?
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
