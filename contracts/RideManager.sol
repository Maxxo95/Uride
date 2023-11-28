// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.9;





contract RideManager {
   
    event RideRequested(address indexed customer);
    event RideAccepted(address indexed driver, address indexed customer);
    event RideCompleted(address indexed driver, address indexed customer);
    
    address public currentDriver;
    address public currentCustomer;
    

    function requestRide() external {
        currentCustomer = msg.sender;
        emit RideRequested(msg.sender);
        
    }

    function acceptRide() external {
        currentDriver = msg.sender;
        emit RideAccepted(msg.sender, currentCustomer);
    }

    function completeRide() external {
        emit RideCompleted(currentDriver, currentCustomer);
        currentDriver = address(0);
        currentCustomer = address(0);
    }
}