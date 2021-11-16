// contracts/MyNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

contract Globetrotters is ERC721, VRFConsumerBase {

    bytes32 internal keyHash;
    address internal vrfCoordinator;
    uint256 internal fee;

    struct Trotter {
        uint256 city;
        uint256 weather;
        uint256 background;
        uint256 color;
        string name;
    }

    Trotter[] public trotters;

    //mappings will go here !!
    mapping(bytes32 => string) requestToTrotterName;
    mapping(bytes32 => address) requestToSender;
    mapping(bytes32 => uint256) requestToTokenId;

    constructor(address _VRFCoordinator, address _LinkToken, bytes32 _keyHash) public
    VRFConsumerBase(_VRFCoordinator, _LinkToken)
    ERC721("Globetrotters", "GLOB") {
        vrfCoordinator = _VRFCoordinator;
        keyHash = _keyHash;
        fee = 0.1 * 10**18; // 0.1 LINK
    }

    function requestNewRandomTrotter (string memory name) public returns (bytes32) {
        bytes32 requestId = requestRandomness(keyHash, fee);
        requestToTrotterName[requestId] = name;
        requestToSender[requestId] = msg.sender;
        return requestId;
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
    internal override {
        //define the creation of the NFT
        uint256 newId = trotters.length;
        uint256 city = (randomNumber % 5) + 1; //1 + random number between 0 and 4 
        uint256 weather = ((randomNumber % 50) / 10) + 1;
        uint256 background = ((randomNumber % 500) / 100) + 1;
        uint256 color = ((randomNumber % 5000) / 1000) + 1;

        trotters.push(
            Trotter(
                city,
                weather,
                background,
                color,
                requestToTrotterName[requestId]
            )
        );
        _safeMint(requestToSender[requestId], newId);
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        require(
            _isApprovedOrOwner(_msgSender(),tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _setTokenURI(tokenId,_tokenURI);
    }

}