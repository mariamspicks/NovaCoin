// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract NovaCoin is ERC20{
    
    constructor (string memory __name, string memory __symbol) ERC20(__name, __symbol) {
       _mint(msg.sender, 1_000_000 * 10 ** decimals());  
    } 

    function getTotalSupply() public view returns(uint256) {
        return totalSupply();
    }

}    