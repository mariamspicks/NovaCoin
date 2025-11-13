// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {NovaCoinAirDrop} from "../src/NovaCoinAirDrop.sol";
import {Script} from "forge-std/Script.sol";

contract DeployNovaCoinAirDrop is Script {
    
    function run() external returns(NovaCoinAirDrop){
        vm.startBroadcast();
        NovaCoinAirDrop token = new NovaCoinAirDrop("NovaCoin", "NVA");
        vm.stopBroadcast();
        return token;
    }
}
