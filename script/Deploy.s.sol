// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Script.sol";
import "../contracts/NEX.sol";
import "../contracts/NexionProfile.sol";
import "../contracts/NexionFeedV2.sol";

contract DeployScript is Script {
    function run() external {
        vm.startBroadcast();
        NEX nex = new NEX(msg.sender);
        NexionProfile profile = new NexionProfile();
        NexionFeedV2 feed = new NexionFeedV2(address(nex), address(profile));
        vm.stopBroadcast();
    }
}