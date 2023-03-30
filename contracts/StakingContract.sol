// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakingPlatform {

  // Mapping from staking pool addresses to their details
  mapping(address => Pool) public PoolsMapping;

  // Total number of all pools that have been created so far
  uint256 public TotalPools = 0;

  /** 
   * @dev Block time for current chain
   * for Ethereeum it's 15 seconds
   * for Polygon it's 2 seconds etc.
   */
  uint256 public ChainBlockTime = 15;

  // One month in seconds
  uint256 public MonthInBlocktime = 2592000 / ChainBlockTime;

  // Struct for storing information about a staking pool
  struct Pool {
    uint256 PoolID;
    ERC20 stakedTokenAddress;
    ERC20 rewardTokenAddress;
    uint256 totalRewardTokenAmount;
    uint256 createdDate;
    uint256 duration;
    bool open;
  }





  /**
   * @dev Function for calculating the APR with following parameters:
   * @param _rewardRate is the rate at which rewards are distributed to stakers per unit time.
   * @param _rewardDuration is the time period for which rewards will be distributed.
   * @param _totalStakedAmount is the total amount of tokens staked in the pool.
   */
  function tokensPerBlock(uint256 _totalYieldTokens, uint256 _totalUsers, uint256 _totalTimeInSeconds) public pure returns (uint256) {
      uint256 time = _totalTimeInSeconds / ChainBlockTime;
      uint256 yieldPerBlock = (_totalYieldTokens / _totalUsers) / _totalTimeInSeconds;
      return yieldPerBlock;
  }





  /**
   * @dev Function for creating a new staking pool.
   * @param _stakedToken is the token that users will stake in order to be elligible for yield.
   * @param _rewardToken is the token in which users receive their yield in.
   * @param _stakingDurationInSeconds is the time period in which rewards will be distributed.
   * @param _totalStakedAmount is the total amount of reward tokens that can be distributed to all stakers in the set amount of time.
   */
  function createPool(address _stakedToken, 
                      address _rewardToken, 
                      uint256 _stakingDurationInSeconds, 
                      uint _totalStakedAmount) public {

    uint256 time = _stakingDurationInSeconds / ChainBlockTime;

    // Checks if the message caller has enough of the reward tokens before going further
    require(erc20.balanceOf(msg.sender) >= _totalStakedAmount, 'Not enough reward tokens!');

    // Tokens need to be locked for at least one month 
    require(time >= MonthInBlocktime, "Staking period too low!");

    /**
     * @dev Increments the @param TotalPools by one everytime before a new pool is created. 
     * Creates a new staking pool with the specified parameters above and with the incremented Pool ID.
     * 
     */
    TotalPools += 1;
    Pool memory newPool = Pool(
        TotalPools,
        _stakedToken, 
        _rewardToken,
        _totalStakedAmount,
        block.number, // Created date
        block.number + (_stakingDurationInSeconds / ChainBlockTime), // Duration in block time
        true
    );
    PoolsMapping[TotalPools] = newPool;
  }





  // Function for staking tokens in a staking pool


  // A function for that let's stakers withdraw yield from a staking pool


  // A function for that let's stakers withdraw all tokens from a staking pool
  

}