# 🗳️ Public Voting Smart Contract

## 📘 What is this?

This is a **Public Voting Smart Contract** built in Solidity. It allows anyone on the Ethereum blockchain to participate in a simple, transparent, and tamper-proof voting process. The contract is designed to be deployed on a local or public Ethereum-compatible blockchain using Hardhat.

## 🎯 Purpose (Why?)

Democracy and decision-making often require secure, fair, and auditable systems. Traditional voting systems can be:

- Centralized and opaque
- Vulnerable to tampering or fraud
- Limited in transparency and auditability

This smart contract addresses those issues by providing:

- ✅ One person = one vote enforcement
- ✅ Transparent, public vote count
- ✅ No need for intermediaries or centralized authorities

## 🔧 Features

- Only contract owner can add candidates
- Any address can vote (one vote per address)
- Voting is time-limited
- Voting results are public and auditable
- Automatic winner detection after voting ends

## 🏗️ How It Works

1. **Owner adds candidates** before voting begins.
2. **Owner starts the voting**, setting a deadline.
3. **Anyone can vote** for a candidate by index.
4. After the deadline, **voting ends** and results can be viewed.

## 🧪 Tech Stack

- Solidity (v0.8.20)
- Hardhat (for development and testing)

## 📜 Smart Contract Overview

### Contract: `PublicVoting.sol`

- `addCandidate(string name)` - Add a candidate (only owner)
- `startVoting(uint durationInSeconds)` - Start voting for a specific duration
- `vote(uint candidateIndex)` - Vote for a candidate
- `endVoting()` - End the voting manually after deadline
- `getWinningCandidate()` - Returns the candidate with the most votes

## 🧑‍💻 Deployment (Hardhat)

```bash
npx hardhat run scripts/deploy.js --network localhost
```

## 🛡️ Security & Limitations

- Only 1 vote per address (enforced by `hasVoted` mapping)
- No private voting (votes are public)
- No off-chain identity validation (trust is based on wallet uniqueness)

## 👨‍💼 License

MIT - Free to use, modify, and distribute.
