// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.9;

contract TaxiCustomer {
    // Customer attributes
    string public name;
    uint public distanceToTravel;
    uint public rideFee; // Added attribute to store the calculated ride fee
    address public owner;
    uint256 public balance;

    // Constructor to initialize customer attributes
    constructor(string memory _name, uint256 _distanceToTravel) public {
        name = _name;
        distanceToTravel = _distanceToTravel;
        owner = msg.sender;
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
    function payForRide() external payable {
        require(msg.value >= rideFee, "Insufficient funds to pay for the ride");

        // Update the balance
        balance += msg.value;
        
        // Additional logic for handling the payment, updating balances, etc.
        // You can transfer the funds to the driver's address or hold them in the contract.
    }

    // Function to withdraw the balance
    function withdrawBalance() external {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(balance > 0, "No balance to withdraw");

        // Perform the withdrawal
        uint256 amountToWithdraw = balance;
        balance = 0;
        msg.sender.transfer(amountToWithdraw);
    }
}
