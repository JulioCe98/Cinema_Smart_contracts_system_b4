# 🎬 Cinema - Solidity Project

**Cinema** is a smart contract system built in **Solidity 0.8.24** that simulates a decentralized cinema token economy.  
The project consists of **3 contracts** working together:  
`CinemaContract`, `CinemaToken`, `CinemaVault`, and an interface `ICinemaToken`.

---

## 🧱 Project Overview

| Contract | Role |
|-----------|------|
| **CinemaContract** | Main contract that manages token purchases and handles communication with both the Vault and Token contracts. |
| **CinemaToken** | ERC20 token that represents the cinema's native token. Only the CinemaContract can mint new tokens. |
| **CinemaVault** | Manages all Ether deposits and withdrawals. Only the CinemaContract can interact with it. |
| **ICinemaToken** | Interface that defines the communication between the CinemaContract and the CinemaToken. |

---

## 🎞️ CinemaContract

The **CinemaContract** is the core of the system.

### 🧩 Key Features
- Stores the addresses of:
  - `CinemaVault`
  - `CinemaToken`
- Allows users to **buy CinemaTokens** by sending Ether.

### ⚙️ Main Methods

| Function | Description |
|-----------|-------------|
| `buyCinemaTokens()` | `payable` method that sends the received Wei to the `CinemaVault`, then mints CinemaTokens in a 1:1 conversion rate and transfers them to the user. |
| `setCinemaTokensConversionRate(uint newRate)` | Sets the conversion rate between Wei and CinemaTokens. Protected by the `onlyOwner` modifier. |

### 🔒 Modifiers
| Modifier | Description |
|-----------|-------------|
| `onlyOwner` | Ensures that only the contract owner can execute administrative actions like changing the conversion rate. |

---

## 🎟️ CinemaToken (ERC20)

The **CinemaToken** contract is an **ERC20 token** with restricted minting capabilities.

### 🧩 Key Features
- Has a stored address of the **CinemaContract**.  
- Tracks the number of tokens minted with a `uint minted` variable.  
- Only the `CinemaContract` can mint new tokens — no external address can call `mint()`.

### ⚙️ Main Variables

| Variable | Type | Description |
|-----------|------|-------------|
| `cinemaContractAddress` | `address` | Authorized contract that can mint tokens. |
| `minted` | `uint` | Tracks total minted tokens. |

---

## 🏦 CinemaVault

The **CinemaVault** contract acts as the project's vault, managing Ether transactions.

### 🧩 Key Features
- Stores deposits and withdrawals made through the system.  
- Uses two arrays to track each movement:
  - `Person[] public deposits`
  - `Person[] public withdraws`
- Ensures ownership through `cinemaAddress` to restrict access to authorized contracts.

### ⚙️ Main Methods

| Function | Description |
|-----------|-------------|
| `depositEther()` | `payable` function that receives Ether from the CinemaContract. Protected by the `isOwner` modifier. |
| `withdrawEther()` | Allows the owner to withdraw funds from the vault. Also protected by `isOwner`. |

### 🔒 Modifiers
| Modifier | Description |
|-----------|-------------|
| `isOwner` | Restricts access to only the `CinemaContract` (the system’s authorized address). |

---

## 🔗 ICinemaToken (Interface)

Defines the interaction between **CinemaContract** and **CinemaToken**.  

