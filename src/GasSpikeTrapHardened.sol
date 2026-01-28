// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ITrap} from "../lib/drosera-contracts/interfaces/ITrap.sol";

contract GasSpikeTrapHardened is ITrap {
    // CORRECTION 3: Ensure this matches deployed MockGasOracle
    address public constant GAS_ORACLE = 0x0000000000000000000000000000000000000000; // UPDATE AFTER DEPLOYMENT
    
    // CORRECTION 1: Explicit units in naming
    uint256 public constant SPIKE_THRESHOLD_GWEI = 100; // 100 gwei threshold
    
    function collect() external view override returns (bytes memory) {
        (bool success, bytes memory data) = GAS_ORACLE.staticcall(
            abi.encodeWithSignature("getGasPrice()")
        );
        
        // Proper hardening: return empty on failure
        if (!success || data.length != 32) {
            return bytes("");
        }
        
        return data;
    }
    
    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        // Strict validation
        if (data.length == 0 || data[0].length != 32) {
            return (false, bytes(""));
        }
        
        uint256 currentGasPriceGwei = abi.decode(data[0], (uint256));
        
        // CORRECTION 1: Compare gwei to gwei (consistent units)
        if (currentGasPriceGwei > SPIKE_THRESHOLD_GWEI) {
            return (true, abi.encode("Gas price spike detected", currentGasPriceGwei));
        }
        
        return (false, bytes(""));
    }
}
