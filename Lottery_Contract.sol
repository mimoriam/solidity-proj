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
}
