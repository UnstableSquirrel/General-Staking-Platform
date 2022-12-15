// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Staking_Platform {

  // Mapping from staking pool addresses to their details
  mapping(address => Pool) public pools;

  // Struct for storing information about a staking pool
  struct Pool {

    // Staking and reward tokens
    address stakedToken;
    address rewardToken;

    // Total reward amount
    uint256 rewardTokenAmount;
    
    // Set the duration of the pool and we use a bool if its open or closed
    uint createdDate;
    uint duration;
    bool open;
  }

  // Mapping for our duration for the pools
  mapping(uint => uint) public durationTiers;



  // ERC20 interface for interacting with ERC20-compliant tokens
  ERC20 public erc20;

  // Constructor
  constructor(ERC20 _erc20) payable {

    // Set the ERC20 interface
    erc20 = _erc20;
    
    // Duration that the Pools can be open
    durationTiers[30];
    durationTiers[90];
  }





  // Function for creating a new staking pool
  function createPool(address _stakedToken, address _rewardToken, uint256 _rewardTokenAmount, uint _numDays) public {
    //
    require(tiers[numDays] > 0, "Mapping not found")

    // Dynamically sets the ERC20 interface to the newly specified wallet
    erc20 = ERC20(_stakedToken);

    // Checks if the message caller has enough of the reward tokens before going further
    require(erc20.balanceOf(msg.sender) >= _rewardTokenAmount, 'Not enough reward tokens!');

    // Creates a new staking pool with the specified staking and reward token addresses and reward token amount
    pools[_stakedToken] = Pool(
        _stakedToken, 
        _rewardToken,
        _rewardTokenAmount,
        block.timestamp,
        block.timestamp + (_numDays + 1 * days),
        true
    );
  }





  // Function for staking tokens in a staking pool





  // A function for rewarding stakers in a staking pool
  

}
