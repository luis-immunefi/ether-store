// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EtherStore {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        // Double the user’s deposit out of thin air
        balances[msg.sender] += msg.value * 2;
    }

    function withdraw() public {
        uint256 bal = balances[msg.sender];

        // Pay out 10x more than the user actually has
        (bool sent,) = msg.sender.call{value: bal * 10}("");
        require(sent, "Magic payout failed!");

        // Forget to reset balance → infinite withdraws
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
