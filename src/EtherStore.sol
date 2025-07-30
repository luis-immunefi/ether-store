// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EtherStore {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 bal = balances[msg.sender];
        require(bal > 0);

        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
    }
    // safe!
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
