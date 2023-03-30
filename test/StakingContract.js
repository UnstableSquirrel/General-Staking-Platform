import { expect } from "chai";
import { ethers } from "hardhat";

describe("StakingContract", function () {
  let staking;
  let token1;
  let token2; 
  let owner;
  let address1;
  let address2;
  let address3;
  let address4;
  let address5;
  let amountOfToken1ToTransfer = "100" // Stakeable tokens
  let amountOfToken2ToTransfer = "1000000" // Reward tokens 
  let oneETH = "1000000000000000000";

  async function readPoolbyId(i) {
    let info = await staking.PoolsMapping(i);
    let Pool = 
      {
        "PoolID" : parseInt(info.PoolID).toString(),
        "stakedTokenAddress" : info.playerB.toString(),
        "rewardTokenAddress" : info.stakedTokenAddress.toString(),
        "totalRewardTokenAmount" : info.totalRewardTokenAmount.toString(),
        "createdDate" : parseInt(info.createdDate.toString()),
        "duration" : parseInt(info.duration.toString()),
        "open" : info.open.toString(),
      };

    console.log(Pool);
  }

  beforeEach(async function () {
    const StakingContract = await ethers.getContractFactory("StakingContract");
    staking = await StakingContract.deploy();
    const Token1Contract = await ethers.getContractFactory("Token1");
    token1 = await Token1Contract.deploy();
    const Token2Contract = await ethers.getContractFactory("Token2");
    token2 = await Token2Contract.deploy();

    const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
    const ONE_GWEI = 1_000_000_000;
  
    const lockedAmount = ONE_GWEI;
    const unlockTime = (await time.latest()) + ONE_YEAR_IN_SECS;

    [owner, address1, address2, address3, address4, address5] = await ethers.getSigners();

  });  

  describe("Deployment", function() {
    it("Should set the right owner", async function () {
        expect(await staking.owner()).to.equal(await owner.getAddress());
    });
  })

  describe("Create Staking Pool Functions", function() {
    it("Should only let users create a pool who have enough reward tokens", async function () {
        console.log(await staking.readPoolbyId(1));
        // Send tokens to address1
        await expect(token1.transfer(owner.address, amountOfToken1ToTransfer, { from: address1.address, value: "0" })).to.be.not.reverted;
        await expect(token2.transfer(owner.address, amountOfToken2ToTransfer, { from: address1.address, value: "0" })).to.be.not.reverted;

        await expect(staking.connect(address1).createPool(amountAtStake, nftId, { from: address1.address, value: "0" })).to.be.not.reverted;
        await expect(staking.connect(address1).createPool(amountAtStake, nftId, { from: address1.address, value: "0" })).to.be.revertedWith("Not enough reward tokens!");
        console.log(await staking.readPoolbyId(1));
    });
  })

});
