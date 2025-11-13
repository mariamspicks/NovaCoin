// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {NovaCoinAirDrop} from "../src/NovaCoinAirDrop.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract AirdropScript is Script {
    
    function run() external {
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS");
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
       
        
        NovaCoinAirDrop coin = NovaCoinAirDrop(tokenAddress);
        
        address[] memory recipients = new address[](15);
        
        recipients[0] = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        recipients[1] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        recipients[2] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
        recipients[3] = 0x90F79bf6EB2c4f870365E785982E1f101E93b906;
        recipients[4] = 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65;
        recipients[5] = 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc;
        recipients[6] = 0x976EA74026E726554dB657fA54763abd0C3a0aa9;
        recipients[7] = 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955;
        recipients[8] = 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f;
        recipients[9] = 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720;
        recipients[10] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
        recipients[11] = 0x0dCC6aa1C1631C956FE7fEeDb170f412a1F9a573;
        recipients[12] = 0x1E878A1d4e610BCC201aff3935F63D5F11D2d0DF;
        recipients[13] = 0x284A9aC11e25bE8E71A1d28C15548063996351e6;
        recipients[14] = 0x1B4473744B410827c92ad836f40A7E2596E485Bc;
        
        
        uint256[] memory amounts = new uint256[](15);
        
        // Each recipient gets 1,000 tokens
        for (uint256 i = 0; i < 15; i++) {
            amounts[i] = 1000 * 10**18;
        }
        
        
        vm.startBroadcast(deployerPrivateKey);
        
        console.log("Starting airdrop...");
        console.log("Token Address:", tokenAddress);
        console.log("Number of Recipients:", recipients.length);
        console.log("Tokens per Recipient:", amounts[0] / 10**18);
        
        // Execute the airdrop
        coin.airdrop(recipients, amounts);
        
        console.log("Airdrop completed successfully!");
        
        vm.stopBroadcast();
    }
}

