// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ITrap} from "../lib/drosera-contracts/interfaces/ITrap.sol";

contract GasSpikeTrap is ITrap {
    // ACTUAL deployed MockGasOracle address (not zero address)
    address public constant GAS_ORACLE = 0x515C71C1C79DCb882F53f7605b21E7D2610a4464;
    
    uint256 public constant SPIKE_THRESHOLD = 100; // gwei
    
    // Debug sentinel: max uint256 indicates failure
    uint256 private constant DEBUG_SENTINEL = type(uint256).max;
    
    function collect() external view override returns (bytes memory) {
        (bool success, bytes memory data) = GAS_ORACLE.staticcall(
            abi.encodeWithSignature("getGasPrice()")
        );
        
        // Return debug sentinel on failure (not empty bytes)
        if (!success || data.length != 32) {
            return abi.encode(DEBUG_SENTINEL);
        }
        
        return data;
    }
    
    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length == 0 || data[0].length != 32) {
            return (false, bytes(""));
        }
        
        uint256 gasPrice = abi.decode(data[0], (uint256));
        
        // Ignore debug sentinel (call failure)
        if (gasPrice == DEBUG_SENTINEL) {
            return (false, bytes("call failed - debug sentinel"));
        }
        
        if (gasPrice > SPIKE_THRESHOLD) {
            return (true, abi.encode("Gas price spike detected. Current: ", gasPrice));
        }
        
        return (false, bytes(""));
    }
}
