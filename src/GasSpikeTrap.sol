// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ITrap} from "../lib/drosera-contracts/interfaces/ITrap.sol";

contract GasSpikeTrap is ITrap {
    // MockGasOracle with correct checksum
    address public constant GAS_ORACLE = 0x515C71C1C79DCb882F53f7605b21E7D2610a4464;
    
    // Threshold: alarm if gas price exceeds 100 gwei
    uint256 public constant SPIKE_THRESHOLD = 100; // gwei
    
    function collect() external view override returns (bytes memory) {
        (bool success, bytes memory data) = GAS_ORACLE.staticcall(
            abi.encodeWithSignature("getGasPrice()")
        );
        
        if (!success || data.length != 32) {
            return bytes("");
        }
        
        return data;
    }
    
    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length == 0 || data[0].length != 32) {
            return (false, bytes(""));
        }
        
        uint256 currentGasPrice = abi.decode(data[0], (uint256));
        
        if (currentGasPrice > SPIKE_THRESHOLD) {
            return (true, abi.encode("Gas price spike detected. Current: ", currentGasPrice));
        }
        
        return (false, bytes(""));
    }
}
