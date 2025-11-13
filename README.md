# 🪙 NovaCoin - ERC-20 Token with Airdrop Mechanism

A custom ERC-20 token smart contract with built-in batch airdrop functionality, deployed on Ethereum Sepolia testnet.

## 📋 Project Overview

This project demonstrates a production-ready ERC-20 token implementation with an efficient airdrop mechanism that enables distributing tokens to multiple addresses in a single transaction, significantly reducing gas costs and complexity.

## ✨ Features

- ✅ **Standard ERC-20 Implementation** - Full compliance with ERC-20 standard
- ✅ **Batch Airdrop Functionality** - Distribute to multiple addresses in one transaction
- ✅ **Access Control** - Owner-only airdrop execution using OpenZeppelin's Ownable
- ✅ **Duplicate Prevention** - Tracking system to prevent duplicate claims
- ✅ **Event Logging** - Comprehensive event emissions for all actions
- ✅ **Edge Case Protection** - Validates inputs and handles errors gracefully
- ✅ **Gas Optimized** - Efficient batch processing using calldata

## 🔧 Token Details

| Property | Value |
|----------|-------|
| **Name** | NovaCoin |
| **Symbol** | NVA |
| **Decimals** | 18 |
| **Total Supply** | 1,000,000 NVA |
| **Network** | Ethereum Sepolia Testnet |
| **Contract Address** | `0xD07d09fF54C15073bc3b33C41727E4c70FbEe0F7` |

## 🚀 Successful Deployment

✅ **Live Airdrop Execution:**
- **Transaction Hash:** [`0x770b2f42d6ad6bfbf5a4fbf8f9701f62719d60586bf3f22a5697ad7e63a4a277`](https://sepolia.etherscan.io/tx/0x770b2f42d6ad6bfbf5a4fbf8f9701f62719d60586bf3f22a5697ad7e63a4a277)
- **Block Number:** 9623262
- **Recipients:** 15 addresses
- **Tokens per Recipient:** 1,000 NVA
- **Gas Used:** 737,593
- **Total Cost:** 0.000000786596466141 ETH

## 📁 Project Structure
```
NovaCoin/
├── src/
│   ├── NovaCoin.sol              # Basic ERC-20 implementation
│   └── NovaCoinAirDrop.sol       # ERC-20 with airdrop functionality
├── script/
│   ├── DeployNovaCoinAirDrop.s.sol    # Deployment script
│   └── ExecuteAirDropScript.s.sol     # Airdrop execution script
├── test/
│   └── TestNovaCoinAirDrop.t.sol       # Comprehensive test suite
├── .env                   # Environment variables template
└── README.md
```

## 🛠️ Smart Contract Functions

### NovaCoinAirDrop.sol

#### `airdrop(address[] calldata recipients, uint256[] calldata amounts)`
Distributes tokens to multiple addresses in a single transaction.

**Access:** Owner only

**Parameters:**
- `recipients` - Array of recipient addresses
- `amounts` - Array of token amounts (in wei)

**Requirements:**
- Arrays must have matching lengths
- Maximum 100 recipients per transaction
- No zero addresses
- All amounts must be greater than zero
- Owner must have sufficient balance

**Emits:**
- `Transfer` events for each recipient
- `AirdropExecuted` event with all recipients and amounts

### Inherited ERC-20 Functions
- `transfer(address to, uint256 amount)`
- `approve(address spender, uint256 amount)`
- `transferFrom(address from, address to, uint256 amount)`
- `balanceOf(address account)`
- `allowance(address owner, address spender)`
- `totalSupply()`

## 🔒 Security Features

1. **Access Control**
   - Only contract owner can execute airdrops
   - OpenZeppelin's Ownable pattern

2. **Input Validation**
   - Array length matching
   - Zero address checks
   - Amount validation
   - Batch size limitations (max 100)

3. **Duplicate Prevention**
   - `hasReceivedAirdrop` mapping tracks claims
   - Prevents double distributions

4. **Safe Math**
   - Solidity 0.8.30 built-in overflow protection

## 📦 Installation & Setup

### Prerequisites
- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Node.js (optional)
- Git

### Install Foundry
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### Clone Repository
```bash
git clone https://github.com/YOUR_USERNAME/novacoin-airdrop.git
cd novacoin-airdrop
```

### Install Dependencies
```bash
forge install
```

### Environment Setup
Create a `.env` file in the root directory:
```bash
cp .env.example .env
```

Edit `.env` with your values:
```
PRIVATE_KEY=0xYOUR_PRIVATE_KEY_HERE
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_PROJECT_ID
TOKEN_ADDRESS=YOUR_DEPLOYED_CONTRACT_ADDRESS
```

⚠️ **Never commit your `.env` file!**

## 🧪 Testing

### Run All Tests
```bash
forge test
```

### Run Tests with Verbosity
```bash
forge test -vv
```

### Run Specific Test
```bash
forge test --match-test test_Airdrop -vvv
```

### Test Coverage
```bash
forge coverage
```

## 📜 Deployment Scripts

### 1. Deploy NovaCoinAirDrop Contract
```bash
forge script script/DeployNovaCoinAirDrop.s.sol:DeployNovaCoinAirDrop \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  -vvvv
```

Save the deployed contract address and update `TOKEN_ADDRESS` in your `.env` file.

### 2. Execute Airdrop
```bash
source .env
forge script script/ExecuteAirDropScript.s.sol:AirdropScript \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  -vvvv
```

## 🎯 Usage Example

### Solidity
```solidity
NovaCoinAirDrop token = NovaCoinAirDrop(0xYourContractAddress);

address[] memory recipients = new address[](3);
recipients[0] = 0xAddress1;
recipients[1] = 0xAddress2;
recipients[2] = 0xAddress3;

uint256[] memory amounts = new uint256[](3);
amounts[0] = 1000 * 10**18;
amounts[1] = 1000 * 10**18;
amounts[2] = 1000 * 10**18;

token.airdrop(recipients, amounts);
```

## 📊 Gas Optimization

The airdrop function uses `calldata` instead of `memory` for array parameters, reducing gas costs:

| Operation | Gas Cost |
|-----------|----------|
| Deploy Contract | ~1,500,000 |
| Airdrop to 15 addresses | 737,593 |
| Average per recipient | ~49,173 |

## 🔍 Verification

Verify contract on Etherscan:
```bash
forge verify-contract \
  --chain-id 11155111 \
  --num-of-optimizations 200 \
  --compiler-version v0.8.30 \
  YOUR_CONTRACT_ADDRESS \
  src/NovaCoinAirDrop.sol:NovaCoinAirDrop \
  --etherscan-api-key YOUR_ETHERSCAN_API_KEY
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👤 Author

**Mariam Tunwashe**
- GitHub: [@mariiamspicks](https://github.com/mariamspicks)

## 🙏 Acknowledgments

- OpenZeppelin for secure contract libraries
- Foundry for development framework
- Ethereum community for support and documentation

## 📞 Support

For questions or issues, please open an issue on GitHub

---

⭐ If you found this project helpful, please give it a star!
