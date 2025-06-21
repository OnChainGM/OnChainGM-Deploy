# 🏗️ OnChainGm Deployment

This project consists of two smart contracts:  
a **factory contract** that allows users to deploy new minimal contracts by paying a fixed fee, and a **child contract** that records the deploying user's address and the fee recipient.

---

## 📦 Contracts Overview

### 🏭 DeploymentFeeFactory.sol

Factory contract that:

- Deploys new `DeploymentFeeContract` instances
- Charges a flat fee per deployment
- Tracks all deployed contracts

### 📄 DeploymentFeeContract.sol

Minimal contract deployed by the factory.  
Stores:

- The address of the user who deployed it
- The address receiving the fee

---

## 💰 Fee Mechanics

| Item             | Value              |
|------------------|--------------------|
| Deployment Fee   | `0.000035 ETH`     |
| Fee Recipient    | [`0x7500...a85`](https://etherscan.io/address/0x7500A83DF2aF99B2755c47B6B321a8217d876a85) |

When a user calls the `deploy()` function of the factory and sends the required fee:
- The fee is transferred to the `feeRecipient`
- A new `DeploymentFeeContract` is deployed with `msg.sender` as its owner
- The factory records the address of the new contract

---

## ⚙️ Function Summary

### DeploymentFeeFactory

```solidity
function deploy() external payable
```
- Requires `msg.value >= 0.000035 ETH`
- Deploys a new `DeploymentFeeContract`
- Emits `ContractDeployed(address contractAddress, address owner)`

```solidity
function getDeployedContracts() external view returns (DeploymentFeeContract[] memory)
```
- Returns an array of all contracts deployed via this factory

---

### DeploymentFeeContract

```solidity
constructor(address _owner, address payable _feeRecipient)
```
- Called by the factory to initialize the new contract

```solidity
address public owner;
address payable public feeRecipient;
```
- Public variables storing ownership and fee metadata

---

## 🧪 Example Usage

### 1. Deploy a Contract via Factory

```solidity
DeploymentFeeFactory.deploy{value: 0.000035 ether}();
```

> You must send **exactly** `0.000035 ETH` or more.

### 2. Query All Deployed Contracts

```solidity
DeploymentFeeFactory.getDeployedContracts();
```

---

## 📜 Events

```solidity
event ContractDeployed(address contractAddress, address owner);
```

Emitted every time a new contract is deployed via the factory.

---

## 🔐 Notes

- There is no admin access or owner on the factory
- All logic is on-chain and permissionless
- The child contracts are minimal, acting only as deployment records

---

## 🧭 License

MIT License — free to use, extend, or integrate in your own dApps.

