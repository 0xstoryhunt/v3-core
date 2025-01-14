pragma solidity ^0.7.6;

import {Script} from "forge-std/Script.sol";
import {Test} from "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import "../contracts/StoryHuntV3PoolDeployer.sol";
import "../contracts/StoryHuntV3Factory.sol";

contract DeploymentScript is Script {
    address public logicAddress;
    address public proxyAddress;
    address public proxyAdminAddress;
    uint256 internal deployerPrivateKey;
    
    //periphery
  address payable V3_POOL_DEPLOYER =  0x0318592f530Ac3C13CD26c197C68b4475e94852d ;
  address payable V3_FACTORY_CONTRACT =  0x6A76afC7417fd6A57fEAe35fB53Fd51eDc08C1ba ;
    //periphery
  address payable MULTICALL_ADDRESS =  0x92D99FFa06edbDDB1B599A92473E4ad19ee485D4 ;
  address payable QUOTER_ADDRESS =  0xFda9cdAFC97aE06A2f7164f4349E623476C5917E ;
  address payable NFT_POSITION_DESCRIPTOR_ADDRESS =  0xef209C17aFd6483b304C73ef0f9F91C01a61c8C2 ;
  address payable NFT_POSITION_MANAGER_ADDRESS =  0xe66015EFdAFc8a116B91e83d02AfB4f737835BA3 ;
  address payable SWAP_ROUTER_ADDRESS =  0xf6b5DaC44dff54069B07dC8919eb35c001d0864c ;
    //lm
    address payable ALPHA_HUNTER_ADDRESS =
        0x3Fb9e55bC8bfa18C1Ebe6098299C64600970CDCE;
    address constant LM_POOL_DEPLOYER_ADDRESS =
        0xD673D22a27C087be1751D5FF05C381a4272bBA39;

    constructor() {
        deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    }

    modifier broadcast(uint256 privateKey) {
        vm.startBroadcast(privateKey);

        _;

        vm.stopBroadcast();
    }


    function deployContracts() external broadcast(deployerPrivateKey) returns (bytes32) {
        StoryHuntV3PoolDeployer poolDeployer = new StoryHuntV3PoolDeployer();
        console.log("address payable V3_POOL_DEPLOYER = ", address(poolDeployer),";");

        StoryHuntV3Factory factory = new StoryHuntV3Factory(address(poolDeployer));
        console.log("address payable V3_FACTORY_CONTRACT = ", address(factory),";");

        poolDeployer.setFactoryAddress(address(factory));

        bytes memory creationCode = type(StoryHuntV3Pool).creationCode;
        bytes32 initCodeHash = keccak256(creationCode);

        return initCodeHash;
    }

    function transferOwnership(address multisig) external broadcast(deployerPrivateKey) {
        IStoryHuntV3Factory factory = IStoryHuntV3Factory(V3_FACTORY_CONTRACT);
        factory.transferOwnership(multisig);
    }

    function addLMPool() external broadcast(deployerPrivateKey) {
        StoryHuntV3Factory factory = StoryHuntV3Factory(V3_FACTORY_CONTRACT);
        factory.setLmPoolDeployer(LM_POOL_DEPLOYER_ADDRESS);
    }

    function run() public returns (bytes32) {
        bytes memory creationCode = type(StoryHuntV3Pool).creationCode;
        bytes32 initCodeHash = keccak256(creationCode);

        return initCodeHash;
    }
}
