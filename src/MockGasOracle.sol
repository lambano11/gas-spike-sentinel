// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Simulates a gas price oracle on Hoodi
contract MockGasOracle {
    address public owner;
    uint256 public currentGasPrice; // in gwei
    
    constructor() {
        owner = msg.sender;
        currentGasPrice = 30; // Start at "normal" 30 gwei
    }
    
    // Function to simulate gas spike (e.g., MEV activity)
    function simulateGasSpike(uint256 _newPrice) external {
        require(msg.sender == owner, "Not owner");
        currentGasPrice = _newPrice;
    }
    
    // Function to return to normal
    function setNormalGas(uint256 _normalPrice) external {
        require(msg.sender == owner, "Not owner");
        currentGasPrice = _normalPrice;
    }
    
    // Get current gas price in gwei
    function getGasPrice() external view returns (uint256) {
        return currentGasPrice;
    }
}
