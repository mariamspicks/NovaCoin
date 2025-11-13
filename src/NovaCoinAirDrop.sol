// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract NovaCoinAirDrop is ERC20, Ownable {
    mapping(address => bool) public hasReceivedAirdrop;

    event AirdropExecuted(address[] recipients, uint256[] amounts);

    constructor(string memory __name, string memory __symbol) ERC20(__name, __symbol) Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply();
    }

    function airdrop(address[] calldata recipients, uint256[] calldata amounts) external onlyOwner {
        require(recipients.length == amounts.length, "Arrays must match");
        require(recipients.length > 0, "Need recipients");
        require(recipients.length <= 100, "Too many recipients");

        for (uint256 i = 0; i < recipients.length; i++) {
            require(recipients[i] != address(0), "Invalid address");
            require(amounts[i] > 0, "Invalid amount");

            _transfer(msg.sender, recipients[i], amounts[i]);
            hasReceivedAirdrop[recipients[i]] = true;
        }

        emit AirdropExecuted(recipients, amounts);
    }
}
