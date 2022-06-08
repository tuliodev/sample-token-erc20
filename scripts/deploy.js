const hre = require("hardhat");

const main = async () => {
  const tokenSampleContractFactory = await hre.ethers.getContractFactory(
    "TokenSample"
  );
  console.log("Deploying Token...");
  const tokenSampleContract = await tokenSampleContractFactory.deploy(
    200 /** Token supply */
  );
  await tokenSampleContract.deployed();

  console.log("Token deployed to:", tokenSampleContract.address);
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
