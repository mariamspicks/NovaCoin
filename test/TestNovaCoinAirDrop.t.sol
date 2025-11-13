// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Test} from "forge-std/Test.sol";
import {NovaCoinAirDrop} from "../src/NovaCoinAirDrop.sol";

contract NovaCoinTest is Test {
    NovaCoinAirDrop public coin;
    address public owner;
    address public user1 = address(0x1);
    address public user2 = address(0x2);
    
    function setUp() public {
        owner = address(this);
        coin = new NovaCoinAirDrop("NovaCoin", "NVC");
    }
    
    function test_Airdrop() public {
        // Check initial balance
        uint256 initialBalance = coin.balanceOf(owner);
        assertGt(initialBalance, 0, "Owner should have tokens");
        
        address[] memory recipients = new address[](2);
        recipients[0] = user1;
        recipients[1] = user2;
        
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 100 * 10**18;
        amounts[1] = 200 * 10**18;
        
        coin.airdrop(recipients, amounts);
        
        assertEq(coin.balanceOf(user1), 100 * 10**18);
        assertEq(coin.balanceOf(user2), 200 * 10**18);
        assertTrue(coin.hasReceivedAirdrop(user1));
        assertTrue(coin.hasReceivedAirdrop(user2));
        
        // Check owner's balance decreased
        assertEq(coin.balanceOf(owner), initialBalance - 300 * 10**18);
    }
    
    function test_OnlyOwnerCanAirdrop() public {
        address[] memory recipients = new address[](1);
        recipients[0] = user1;
        
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 100 * 10**18;
        
        vm.prank(user1);
        vm.expectRevert();
        coin.airdrop(recipients, amounts);
    }
    
    // Additional test suggestions:
    function test_RevertWhenArraysDontMatch() public {
        address[] memory recipients = new address[](2);
        recipients[0] = user1;
        recipients[1] = user2;
        
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 100 * 10**18;
        
        vm.expectRevert("Arrays must match");
        coin.airdrop(recipients, amounts);
    }
    
    function test_RevertWhenZeroAddress() public {
        address[] memory recipients = new address[](1);
        recipients[0] = address(0);
        
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 100 * 10**18;
        
        vm.expectRevert("Invalid address");
        coin.airdrop(recipients, amounts);
    }
}