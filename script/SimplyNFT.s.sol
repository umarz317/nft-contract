import "forge-std/Script.sol";

import "../src/SimpleNFT.sol";

contract DeploySimpleNFT is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        SimpleNFT simpleNFT = new SimpleNFT();

        console.log("SimpleNFT Deployed At:", address(simpleNFT));

        console.log("Deployer Address: ", vm.addr(deployerPrivateKey));

        console.log("NFT Name", simpleNFT.name());
        
        console.log("NFT Symbol", simpleNFT.symbol());

        vm.stopBroadcast();
    }
}
