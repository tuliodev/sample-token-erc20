const hre = require("hardhat");

const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const tokenSampleContractFactory = await hre.ethers.getContractFactory(
    "TokenSample"
  );

  const tokenSampleContract = await tokenSampleContractFactory.deploy(
    2000000 /** Token supply */
  );
  await tokenSampleContract.deployed();

  const getUserBalanceOf = async (user) => {
    let balanceOf = await tokenSampleContract
      .connect(user)
      .balanceOf(user.address);

    return balanceOf;
  };

  console.log("Contract address:", tokenSampleContract.address);

  // Get total supply

  let totalSupply = await tokenSampleContract.totalSupply();
  
  // transfer to random user

  await tokenSampleContract.connect(owner).transfer(randomPerson.address, 20);

  let balanceOf = await getUserBalanceOf(randomPerson);

  console.log("Random person balanceof => ", balanceOf)

  balanceOf = await getUserBalanceOf(owner);

  console.log("Owner balanceof => ", balanceOf)

};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
