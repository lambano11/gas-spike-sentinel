// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasSpikeResponseSecure {
    address public owner;
    address public authorizedCaller; // CORRECTION 2: For Drosera executor
    
    event GasSpikeAlert(address indexed trap, uint256 gasPriceGwei, string message);
    
    constructor() {
        owner = msg.sender;
    }
    
    // CORRECTION 2: Allow owner to set Drosera executor
    function setAuthorizedCaller(address _caller) external {
        require(msg.sender == owner, "Not owner");
        authorizedCaller = _caller;
    }
    
    // CORRECTION 2: Allow both owner AND Drosera executor
    modifier onlyAuthorized() {
        require(msg.sender == owner || msg.sender == authorizedCaller, "Not authorized");
        _;
    }
    
    function executeResponse(bytes memory responseData) external onlyAuthorized {
        (string memory message, uint256 gasPriceGwei) = abi.decode(responseData, (string, uint256));
        emit GasSpikeAlert(msg.sender, gasPriceGwei, message);
    }
}
