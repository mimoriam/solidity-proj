// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Lottery {
    // The number of players that can take part in lottery
    address payable[] public players;

    // The owner of the smart contract
    address public manager;

    constructor() {
        // Set the owner of the contract by the contract compiler
        manager = msg.sender;
    }

    // Add the player who sents ether (in wei) to the list of users playing the lottery
    receive() external payable {
        require(msg.value == 0.1 ether);
        // Only execute next lines if ether sent is 0.1
        players.push(payable(msg.sender));
    }

    // Simple function to get total balance of the lottery
    function getBalance() public view returns (uint) {
        require(msg.sender == manager);
        // Only the owner can execute the next lines
        return address(this).balance;
    }

    // Now we need to return random user who wins the lottery
    // Solidity has no random function so, we gotta make one:
    function random() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }
}
