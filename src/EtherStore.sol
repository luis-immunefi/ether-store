// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EtherStore {
    mapping(address => uint256) public balances;

    event DepositReceived(address indexed from, uint256 amount, string message);
    event YouMightBePoor(address indexed user, uint256 balance);

    function deposit() public payable {
        balances[msg.sender] += msg.value;

        emit DepositReceived(msg.sender, msg.value, 
            msg.value >= 1 ether 
                ? "Wow, big spender!"
                : "Thanks for the coffee money.");
    }

    function withdraw() public {
        uint256 bal = balances[msg.sender];
        require(bal > 0, "You have no funds to withdraw. Nice try.");

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether. Maybe next time.");

        balances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function amIPoor() public view returns (bool) {
        if (balances[msg.sender] < 0.01 ether) {
            return true;
        } else {
            return false;
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
}
