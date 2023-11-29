// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.9;
import "./RideManager.sol";
contract TaxiDriver {
    // Driver attributes
    string public name;
    address public driverAddress;
    bool public isAvailable = false;
    RideManager public manager;

    // Events
    event DriverRegistered(address indexed driverAddress, string name);
    event RideStarted(address indexed driverAddress);
    event RideEnded(address indexed driverAddress);
   event turnedOff(address indexed driverAddress);
   
    // Constructor to register the driver
    constructor(string memory _name) public {
        name = _name;
        driverAddress = msg.sender;
        isAvailable = true;
        emit DriverRegistered(driverAddress, name);
    }
    
 function acceptRide(address  _manAdd) external {
    manager = RideManager(_manAdd);
    manager.acceptRide(driverAddress);
}



    // Function to set availability status
function turnOff() external {
    require(msg.sender == driverAddress, "Only the driver can turn off the taxi");

    if (isAvailable == true) {
        isAvailable = false;
    } else {
        isAvailable = true;
        
      
    }

    emit turnedOff(driverAddress);
}



    // Function to mark the start of a ride
    function startRide() external {
        require(msg.sender == driverAddress, "Only the driver can start a ride");
        require(isAvailable, "Driver must be available to start a ride");
        emit RideStarted(driverAddress);
        isAvailable = false;
    }

    // Function to mark the end of a ride
    function endRide() external {
        require(msg.sender == driverAddress, "Only the driver can end a ride");
        emit RideEnded(driverAddress);
         isAvailable = true;
    }



   
}
