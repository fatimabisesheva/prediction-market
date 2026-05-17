# Prediction Market Platform

## Overview

Prediction Market Platform is a decentralized application (dApp) built with Solidity, Foundry, React, and Ethers.js.

The platform allows users to participate in prediction markets by buying YES or NO shares on future events.

Example market:

> Will BTC exceed 100k?

Users can:

* Buy YES shares
* Buy NO shares
* Participate in governance
* Interact with decentralized smart contracts
* Use MetaMask wallet connection

The project demonstrates advanced Ethereum smart contract development concepts including governance, upgradeability, ERC standards, vaults, testing, and deployment.

---

# Features

## Smart Contracts

### GovToken (ERC20Votes)

Governance token used for voting and protocol governance.

Features:

* ERC20 token
* Voting support
* Permit signatures
* Minting functionality
* Governance integration

### PredictionMarket

Main market contract.

Features:

* Buy YES shares
* Buy NO shares
* Claim rewards
* Market resolution
* Reward distribution
* Reentrancy protection

### PredictionMarketFactory

Factory contract used to deploy markets.

Features:

* Create markets dynamically
* CREATE2 deterministic deployment
* Store deployed market addresses

### FeeVault (ERC4626)

Vault contract for protocol treasury.

Features:

* Tokenized vault
* Deposit assets
* Withdraw assets
* Treasury management

### PriceOracle

Chainlink-style oracle contract.

Features:

* Price feeds
* Stale price protection
* External data integration

### MyGovernor

DAO governance contract.

Features:

* Proposal voting
* Timelock governance
* Governance thresholds
* Voting delay
* Voting period

### UUPS Upgradeable Contracts

Upgradeable architecture.

Contracts:

* CounterV1
* CounterV2

Features:

* Upgradeable logic
* Owner-controlled upgrades
* UUPS proxy pattern

---

# Technologies Used

## Blockchain

* Solidity
* Foundry
* OpenZeppelin
* Anvil

## Frontend

* React
* Vite
* Ethers.js
* MetaMask

## Standards

* ERC20Votes
* ERC1155
* ERC4626
* UUPS Upgradeable
* Governor
* Timelock

---

# Security Features

The project implements several smart contract security practices.

## ReentrancyGuard

Used to prevent reentrancy attacks.

## SafeERC20

Used for safe token transfers.

## Access Control

Owner-only functions secured with Ownable.

## Oracle Validation

Price freshness checks implemented.

## Upgrade Authorization

Only authorized owner can upgrade contracts.

---

# Testing

The project includes extensive testing using Foundry.

## Unit Tests

Tests for:

* Token minting
* Market creation
* Buying shares
* Claiming rewards
* Governance logic

## Fuzz Tests

Randomized testing for:

* Buy amounts
* Reward claims
* Market states
* Edge cases

## Invariant Tests

Invariant testing for:

* Share consistency
* Market validity
* Contract balances
* State integrity

Commands:

```bash
forge test
```

---

# Deployment

## Local Blockchain Deployment

The project was deployed locally using:

* Anvil
* MetaMask
* Foundry scripts

Deployment command:

```bash
forge script script/Deploy.s.sol:DeployScript --rpc-url http://127.0.0.1:8545 --broadcast
```

---

# Frontend

The frontend was built using React and Ethers.js.

Features:

* Wallet connection
* MetaMask integration
* Token balance display
* Approve token
* Buy YES shares
* Buy NO shares
* Modern UI design

Run frontend:

```bash
cd frontend
npm install
npm run dev
```

---

# Architecture

```text
User
  ↓
Frontend (React + Ethers.js)
  ↓
MetaMask
  ↓
PredictionMarketFactory
  ↓
PredictionMarket
  ↓
GovToken / Vault / Governance
```

---

# Example Workflow

1. User connects MetaMask
2. User approves GovToken
3. User buys YES or NO shares
4. Oracle resolves market
5. Winners claim rewards
6. DAO governance manages protocol

---

# Requirements Covered

The project satisfies the following advanced blockchain development requirements:

* ERC20Votes
* ERC1155
* ERC4626
* CREATE2 deployment
* Factory pattern
* Governance DAO
* Timelock
* UUPS upgradeability
* Chainlink oracle integration
* Unit tests
* Fuzz tests
* Invariant tests
* Local blockchain deployment
* Frontend integration
* MetaMask integration

---

# Future Improvements

Possible future improvements:

* Real oracle integration
* Multiple prediction markets
* Liquidity pools
* Real-time analytics
* Better UI/UX
* Mobile responsiveness
* Arbitrum deployment
* The Graph integration

---

# Conclusion

This project demonstrates advanced Ethereum smart contract engineering concepts including governance, upgradeability, token standards, decentralized market logic, testing, and frontend integration.

The platform combines blockchain backend architecture with a modern Web3 frontend to create a complete decentralized prediction market application.

---

# Defense Preparation

## What is this project?

This project is a decentralized prediction market platform where users can buy YES or NO shares on future events.

---

## Why did you use ERC20Votes?

ERC20Votes was used to support decentralized governance and DAO voting.

---

## Why did you use ERC4626?

ERC4626 provides a standardized tokenized vault architecture for treasury and fee management.

---

## Why use UUPS?

UUPS upgradeability allows updating smart contract logic without losing storage or protocol state.

---

## Why use Factory Pattern?

Factory contracts allow scalable deployment of multiple prediction markets.

---

## What security practices did you implement?

* ReentrancyGuard
* SafeERC20
* Access Control
* Oracle validation
* Upgrade authorization

---

## What testing did you perform?

* Unit tests
* Fuzz tests
* Invariant tests

---

## Why use Foundry?

Foundry provides fast Solidity testing, deployment, fuzzing, and invariant testing.

---

## What is the role of governance?

Governance allows token holders to vote on protocol changes and market management.

---

## What blockchain tools were used?

* Solidity
* Foundry
* OpenZeppelin
* React
* Ethers.js
* MetaMask
* Anvil
