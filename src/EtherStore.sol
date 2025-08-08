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

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

function roastMe() public view returns (string memory) {
        if (balances[msg.sender] == 0) {
            return "You’re so broke, even this contract pities you.";
        } else if (balances[msg.sender] < 0.01 ether) {
            return "Technically, you're rich — in spirit.";
        } else if (balances[msg.sender] < 1 ether) {
            return "You're doing okay. Ish.";
        } else {
            return "Damn, someone call Forbes!";
        }
}
