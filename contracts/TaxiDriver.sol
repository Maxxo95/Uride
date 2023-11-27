// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.9;

contract TaxiDriver {
    // Driver attributes
    string public name;
    address public driverAddress;
    bool public isAvailable;
    uint256 public earnings;

    // Events
    event DriverRegistered(address indexed driverAddress, string name);
    event RideStarted(address indexed driverAddress);
    event RideEnded(address indexed driverAddress);
    event EarningsWithdrawn(address indexed driverAddress, uint256 amount);

    // Constructor to register the driver
    constructor(string memory _name) public {
        name = _name;
        driverAddress = msg.sender;
        isAvailable = true;
        emit DriverRegistered(driverAddress, name);
    }

    // Function to set availability status
    function setAvailability(bool _isAvailable) external {
        require(msg.sender == driverAddress, "Only the driver can set availability");
        isAvailable = _isAvailable;
    }

    // Function to mark the start of a ride
    function startRide() external {
        require(msg.sender == driverAddress, "Only the driver can start a ride");
        require(isAvailable, "Driver must be available to start a ride");
        emit RideStarted(driverAddress);
    }

    // Function to mark the end of a ride
    function endRide() external {
        require(msg.sender == driverAddress, "Only the driver can end a ride");
        emit RideEnded(driverAddress);
    }



   
}
