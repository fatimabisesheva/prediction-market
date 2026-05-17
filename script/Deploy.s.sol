// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";

import "../src/tokens/GovToken.sol";
import "../src/factory/PredictionMarketFactory.sol";
import "../src/oracle/PriceOracle.sol";
import "../src/vault/FeeVault.sol";

contract DeployScript is Script {

    function run() external {

        uint256 deployerKey =
            vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);

        GovToken govToken =
            new GovToken();

        PredictionMarketFactory factory =
            new PredictionMarketFactory();

        FeeVault vault =
            new FeeVault(address(govToken));
factory.createMarket(
    address(govToken),
    "Will BTC exceed 100k?"
);
        vm.stopBroadcast();
    }
}