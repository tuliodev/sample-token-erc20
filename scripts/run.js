const hre = require("hardhat");

const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const tokenSampleContractFactory = await hre.ethers.getContractFactory(
    "TokenSample"
  );

  const tokenSampleContract = await tokenSampleContractFactory.deploy(
    200 /** Token supply */
  );
  await tokenSampleContract.deployed();

  console.log("Contract address:", tokenSampleContract.address);

  // Get total supply

  let totalSupply = await tokenSampleContract.totalSupply();
  console.log("Total supply: ", totalSupply);

  // get balance of a user

  let balanceOf = await tokenSampleContract
    .connect(randomPerson)
    .balanceOf(randomPerson.address);
  console.log("Balance of: ", balanceOf);
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
