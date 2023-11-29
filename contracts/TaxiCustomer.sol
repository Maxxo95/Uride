// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.9;

import "./RideManager.sol";

contract TaxiCustomer {
    // Customer attributes
    string public name;
    uint public distanceToTravel;
    address public customerAddress;
    uint public rideFee; // Added attribute to store the calculated ride fee
    uint public balanceReceived;
    RideManager public manager;
    
      // Events
     event CustomerRegistered(address indexed customerAddress, string name);
     

    // Constructor to initialize customer attributes
    constructor(string memory _name) public {
        name = _name;
       customerAddress = msg.sender;
       emit CustomerRegistered(customerAddress, name);
    }
    function withdrawMoney() public{
        address payable to = payable(msg.sender);
        to.transfer(getBalance());
    }
     function getBalance() public view returns(uint){
        return address(this).balance;
    }
    function getFee() public view returns(uint){
        return rideFee;
    }
    // Function to update the distance to travel
    function DistanceToTravel(uint256 _newDistance) external {
        distanceToTravel = _newDistance;
        calculateRideFee(); // Recalculate ride fee when distance is updated
    }
          function addToBalance()public payable { 
        balanceReceived += msg.value;
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

    // Function to request a ride
    function requestRide( address _managerAddress) external {
          manager = RideManager(_managerAddress);
       manager.requestRide(customerAddress) ;
    }
     
    

    // Function to pay for the ride
   function payforRide(address payable _to) public {
         _to.transfer(getFee());
    }
}
