// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasSpikeResponse {
    event GasSpikeAlert(address indexed trap, uint256 gasPrice, string message);
    
    // NO ACCESS CONTROL - Drosera must be able to call this directly
    function executeResponse(bytes memory responseData) external {
        (string memory message, uint256 gasPrice) = abi.decode(responseData, (string, uint256));
        emit GasSpikeAlert(msg.sender, gasPrice, message);
    }
}
