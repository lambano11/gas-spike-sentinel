// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {MockGasOracle} from "../src/MockGasOracle.sol";

contract DeployMockGasOracleScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        MockGasOracle oracle = new MockGasOracle();
        
        vm.stopBroadcast();
        
        console.log("MockGasOracle deployed at:", address(oracle));
        console.log("Initial gas price:", oracle.currentGasPrice(), "gwei");
    }
}
