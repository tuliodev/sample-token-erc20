const main = async () => {
  const tokenSampleContractFactory = await hre.ethers.getContractFactory(
    "TokenSample"
  );

  const tokenSampleContract = await tokenSampleContractFactory.deploy();
  await tokenSampleContract.deployed();

  console.log("Contract address:", tokenSampleContract.address);
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
