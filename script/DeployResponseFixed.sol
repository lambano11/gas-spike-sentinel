// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract GasSpikeResponseFixed {
    event GasSpikeAlert(address indexed trap, uint256 gasPrice, string message);
    
    function executeResponse(bytes memory responseData) external {
        (string memory message, uint256 gasPrice) = abi.decode(responseData, (string, uint256));
        emit GasSpikeAlert(msg.sender, gasPrice, message);
    }
}

contract DeployResponseFixedScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        GasSpikeResponseFixed response = new GasSpikeResponseFixed();
        
        vm.stopBroadcast();
        
        console.log("GasSpikeResponseFixed deployed at:", address(response));
    }
}
