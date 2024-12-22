const { ethers } = require('hardhat')

async function computeInitCodeHash() {
  const factory = await ethers.getContractFactory('StoryHuntV3Pool')
  const bytecode = factory.bytecode
  const hash = ethers.utils.keccak256(bytecode)
  console.log('POOL_INIT_CODE_HASH:', hash)
}

computeInitCodeHash()
