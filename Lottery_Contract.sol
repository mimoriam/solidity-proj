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
        // Only execute next lines if ether sent is 0.1
        require(msg.value == 0.1 ether);
        players.push(payable(msg.sender));
    }

    // Simple function to get total balance of the lottery
    function getBalance() public view returns (uint) {
        // Only the owner can execute the next lines
        require(msg.sender == manager);
        return address(this).balance;
    }

    // Now we need to return random user who wins the lottery
    // Solidity has no random function so, we gotta make one:
    function random() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    function pickWinner() public {
        // Only manager is allowed to execute below lines
        require(msg.sender == manager);
        require(players.length >= 3);
        // The lottery has a criteria of min 3 players to be added to execute below lines

        uint rand = random();
        // calling function defined above
        address payable winner;

        uint index = rand % players.length;
        winner = players[index];

        winner.transfer(getBalance());
    }
}
