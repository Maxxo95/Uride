// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.9;

contract TaxiCustomer {
    // Customer attributes
    string public name;
    uint public distanceToTravel;
    uint256 public balance;
    uint public rideFee; // Added attribute to store the calculated ride fee
    address public owner;

    // Constructor to initialize customer attributes
    constructor(string memory _name, uint256 _distanceToTravel, address _owner) public {
        name = _name;
        distanceToTravel = _distanceToTravel;
        owner = _owner;
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

        // Transfer funds to the driver's contract
        (bool success, ) = driverContract.call{value: msg.value}("");
        require(success, "Payment to driver failed");
    }

    // Function to withdraw the balance
    function withdrawBalance() external {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(balance > 0, "No balance to withdraw");

        // Perform the withdrawal
        uint256 amountToWithdraw = balance;
        balance = 0;
        (bool success, ) = msg.sender.call{value: amountToWithdraw}("");
        require(success, "Withdrawal failed");
    }
}
