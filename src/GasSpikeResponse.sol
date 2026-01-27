// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasSpikeResponse {
    address public immutable owner;
    event GasSpikeAlert(address indexed trap, uint256 gasPrice, string message);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }
    
    function executeResponse(bytes memory responseData) external onlyOwner {
        (string memory message, uint256 gasPrice) = abi.decode(responseData, (string, uint256));
        emit GasSpikeAlert(msg.sender, gasPrice, message);
    }
}
