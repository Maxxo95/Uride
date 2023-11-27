// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.9;

contract TaxiCustomer {
    // Customer attributes
    string public name;
    uint public distanceToTravel;
    
    uint public rideFee; // Added attribute to store the calculated ride fee
    address public driver;

    // Constructor to initialize customer attributes
    constructor(string memory _name, uint256 _distanceToTravel) public {
        name = _name;
        distanceToTravel = _distanceToTravel;
        
        calculateRideFee(); // Calculate ride fee when the customer is created
    }

    // Function to update the distance to travel
    function updateDistanceToTravel(uint256 _newDistance) external {
        distanceToTravel = _newDistance;
        calculateRideFee(); // Recalculate ride fee when distance is updated
    }

    // Function to calculate the ride fee
    function calculateRideFee() internal {
        if (distanceToTravel <= 10) {
            rideFee = distanceToTravel * 0.5 ether; // 0.5 ether per km for the first 10 km
        } else {
            uint additionalDistance = distanceToTravel - 10;
            rideFee = 10 * 0.5 ether + additionalDistance * 0.7 ether; // 0.7 ether per km after the first 10 km
        }
    }
 // Function to pay for the ride
function payForRide(address driverContract) external payable {
    require(msg.value >= rideFee, "Insufficient funds to pay for the ride");
 driver = driverContract;
    // Trigger the payment in the Driver contract using a safer approach
    (bool success, ) = driverContract.call{value: msg.value}("");
    require(success, "Payment to driver failed");
}



}
