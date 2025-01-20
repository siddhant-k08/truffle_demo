// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Blockchain{

    struct Block{
        uint256 index;
        uint256 timestamp;
        string data;
        bytes32 previousHash;
        bytes32 hash;
    }

    Block[] public blockchain;

    constructor(){
        blockchain.push(Block(0, block.timestamp, "Genesis Block", 0x0, calculateHash(0, block.timestamp, "Genesis Block", 0x0)));
    }

    function createBlock(string memory data) public{
        Block memory previousBlock = blockchain[blockchain.length - 1];
        uint256 newIndex = previousBlock.index + 1;
        bytes32 newHash = calculateHash(newIndex, block.timestamp, data, previousBlock.hash);
        blockchain.push(Block(newIndex, block.timestamp, data, previousBlock.hash, newHash));
    }

    function calculateHash(
        uint256 index,
        uint256 timestamp,
        string memory data,
        bytes32 previousHash
    ) private pure returns (bytes32){
        return keccak256(abi.encodePacked(index, timestamp, data, previousHash));
    }

    function getBlock(uint256 index) public view returns(Block memory){
        require(index < blockchain.length, "Block does not exist.");
        return blockchain[index];
    }
}