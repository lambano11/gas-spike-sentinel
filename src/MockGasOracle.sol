// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockGasOracle {
    uint256 public currentGasPriceGwei = 30; // Default: 30 gwei
    
    function getGasPrice() external view returns (uint256) {
        return currentGasPriceGwei; // Returns gas price in GWEI
    }
    
    function setGasPrice(uint256 newPriceGwei) external {
        currentGasPriceGwei = newPriceGwei;
    }
}
