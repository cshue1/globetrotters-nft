// contracts/MyNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "./interfaces/IOpenWeatherIcon.sol";
import "./interfaces/IOpenWeatherTemp.sol";
contract Globetrotters is ERC721, VRFConsumerBase {

    bytes32 internal keyHash;
    address internal vrfCoordinator;
    uint256 internal fee;
    address internal openWeatherIconAddress;
    address internal openWeatherTempAddress;

    struct Trotter {
        string city;
        string weather;
        string background;
        string color;
        string temperature;
    }

    Trotter[] public trotters;

    mapping(bytes32 => address) requestToSender;
    mapping(bytes32 => uint256) requestToTokenId;
    mapping(uint256 => string) trotterCityIdToCity;
    mapping(uint256 => string) trotterColorIdToColor;

    constructor(address _openWeatherIconAddress, address _openWeatherTempAddress, address _VRFCoordinator, address _LinkToken, bytes32 _keyHash) public
    VRFConsumerBase(_VRFCoordinator, _LinkToken)
    ERC721("Globetrotters", "GLOB") {

        openWeatherIconAddress = _openWeatherIconAddress;
        openWeatherTempAddress = _openWeatherTempAddress;

        vrfCoordinator = _VRFCoordinator;
        keyHash = _keyHash;
        fee = 0.1 * 10**18; // 0.1 LINK

        trotterCityIdToCity[0] = "New York City";
        trotterCityIdToCity[1] = "London";
        trotterCityIdToCity[2] = "Paris";
        trotterCityIdToCity[3] = "San Francisco";
        trotterCityIdToCity[4] = "Chicago";

        trotterColorIdToColor[0] = "3F8A8C";
        trotterColorIdToColor[1] = "0C5679";
        trotterColorIdToColor[2] = "0B0835";
        trotterColorIdToColor[3] = "E5340B";
        trotterColorIdToColor[4] = "F28A0F";
        trotterColorIdToColor[5] = "FFE7BD";
    }

    function requestNewRandomTrotter () public returns (bytes32) {
        bytes32 requestId = requestRandomness(keyHash, fee);
        requestToSender[requestId] = msg.sender;
        return requestId;
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
    internal override {
        //define the creation of the NFT
        uint256 newId = trotters.length;
        uint256 cityId = (randomNumber % 5); // random number between 0 and 4 
        uint256 backgroundId = ((randomNumber % 500) / 100);
        uint256 colorId = ((randomNumber % 5000) / 1000);

        trotters.push(
            Trotter(
                trotterCityIdToCity[cityId],
                IOpenWeatherIcon(openWeatherIconAddress).weather(),
                trotterColorIdToColor[backgroundId],
                trotterColorIdToColor[colorId],
                IOpenWeatherTemp(openWeatherTempAddress).temperature()
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