# Globetrotters NFT

## Submission for 2021 Fall Chainlink Hackathon
### Team Members
- Christine Shue
  - Discord: porkshumai#0497
  - Email: cshue1@fordham.edu

- Kevin Gibson
  - Discord: Kevin__#4462
  - Email: kevin@risemarketinginc.com

## Overview
Globetrotters NFT is a randomly generated dynamic NFT project. The NFT will use the Chainlink VRF to produce provably random numbers that will correlate to different attributes. Two attributes will be generated by the temperature and weather of the corresponding city using Chainlink's decentralized oracle network to connect to an external API.

## Technologies
- Chainlink VRF
- Chainlink Decentralized Oracle Network
- Filecoin (IPFS)

##Requirements
- NPM


## Installation

1. Install truffle

```bash
yarn global add truffle
```

2. Setup repo

```bash
git clone https://github.com/cshue1/globetrotters-nft.git
cd weather-nft 
yarn
truffle migrate --network  mumbai
```

3. Deploy

```
truffle migrate --network XXXX
```

### Verify


```
yarn add truffle-plugin-verify
truffle run verify WeatherNFT --network XXXX --license MIT
truffle run verify WeatherFeed --network XXXX --license MIT
```

### Filecoin examples:
```
ipfs cat /ipfs/Qma6xchqf66CQF5oHf3QLnoB7R1RYcLUny6FScNHtX3cdt > test.png
ipfs cat /ipfs/QmdHkSD571zSpypmb6a3aV26YWMSTrHuk6dAL2Rdqid74U > test2.png
```
