async function main() {
  const [deployer] = await ethers.getSigners()
  const balance = await deployer.getBalance()
  console.log('Deploying contracts with account:', deployer.address)
  console.log('Account balance:', ethers.utils.formatEther(balance), 'IP')

  const network = await ethers.provider.getNetwork()
  console.log('Deploying to network:', network.name)

  const StoryHuntV3Factory = await ethers.getContractFactory('StoryHuntV3Factory')
  console.log('Deploying StoryHuntV3Factory...')

  // Check if bytecode is present
  if (!StoryHuntV3Factory.bytecode || StoryHuntV3Factory.bytecode === '0x') {
    throw new Error('Contract bytecode is empty. Check the compilation artifacts.')
  }

  const storyHuntV3Factory = await StoryHuntV3Factory.deploy()
  console.log('Transaction hash:', storyHuntV3Factory.deployTransaction.hash)

  await storyHuntV3Factory.deployed()
  console.log('Contract deployed at:', storyHuntV3Factory.address)

  console.log('Verifying contract...')
  try {
    await run('verify:verify', {
      address: storyHuntV3Factory.address,
      constructorArguments: [],
    })
    console.log('Contract verified successfully!')
  } catch (error) {
    console.error('Verification failed:', error)
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('Error in deployment:', error)
    process.exit(1)
  })
