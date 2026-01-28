// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {MockGasOracle} from "../src/MockGasOracle.sol";
import {GasSpikeResponseSecure} from "../src/GasSpikeResponseSecure.sol";

contract DeployGasSpikeScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        // Deploy MockGasOracle
        MockGasOracle oracle = new MockGasOracle();
        
        // Deploy Response with proper access control
        GasSpikeResponseSecure response = new GasSpikeResponseSecure();
        
        vm.stopBroadcast();
        
        console.log("MockGasOracle deployed at:", address(oracle));
        console.log("GasSpikeResponseSecure deployed at:", address(response));
        console.log("Response owner:", response.owner());
        console.log("Initial gas price:", oracle.currentGasPriceGwei(), "gwei");  // FIXED: currentGasPriceGwei
    }
}
