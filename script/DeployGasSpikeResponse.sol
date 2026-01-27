// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {GasSpikeResponse} from "../src/GasSpikeResponse.sol";

contract DeployGasSpikeResponseScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        GasSpikeResponse response = new GasSpikeResponse();
        
        vm.stopBroadcast();
        
        console.log("GasSpikeResponse deployed at:", address(response));
        console.log("Owner:", response.owner());
    }
}
