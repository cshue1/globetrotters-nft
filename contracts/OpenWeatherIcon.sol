// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

/**
 * Request testnet LINK and ETH here: https://faucets.chain.link/
 * Find information on LINK Token Contracts and get the latest ETH and LINK faucets here: https://docs.chain.link/docs/link-token-contracts/
 */

/**
 * THIS IS AN EXAMPLE CONTRACT WHICH USES HARDCODED VALUES FOR CLARITY.
 * PLEASE DO NOT USE THIS CODE IN PRODUCTION.
 */
contract OpenWeatherIcon is ChainlinkClient {
    using Chainlink for Chainlink.Request;
    
    string public weather;
    string public city;
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    bytes32 private apiKey;
    
    mapping(string => uint256) private cityToCityId;

    constructor(address _oracle, bytes32 _jobId, bytes32 _apiKey) public {
        setPublicChainlinkToken();
        oracle = _oracle;
        jobId = _jobId;
        apiKey = _apiKey;
        fee = 0.1 * 10 ** 18;
        weather = "Clear";
        city = "New York City";

        cityToCityId["New York City"] = 5128581;
        cityToCityId["London"] = 2643743;
        cityToCityId["Paris"] = 2968815;
        cityToCityId["San Francisco"] = 5391959;
        cityToCityId["Chicago"] = 4887398;
        
    }

    /*constructor() public {
        setPublicChainlinkToken();
        oracle = 0x3A56aE4a2831C3d3514b5D7Af5578E45eBDb7a40; // Kovan
        jobId = "187bb80e5ee74a139734cac7475f3c6e"; //HttpGet > JsonParse > EthBytes32 for Kovan
        fee = 0.1 * 10 ** 18; // (Varies by network and job)
        apiKey = "60c410e380bce538ecb359dd84ae70e7";
        weather = "";

        cityToCityId["New York City"] = 5128581;
        cityToCityId["London"] = 2643743;
        cityToCityId["Paris"] = 2968815;
        cityToCityId["San Francisco"] = 5391959;
        cityToCityId["Chicago"] = 4887398;
    }*/
    
    function setCity(string memory _city) public {
        city = _city;
    }

    function getCity() public view returns (string memory) {
        return city;
    }

    function setWeather(string memory _weather) public {
        weather = _weather;
    }

    function getWeather() public view returns (string memory) {
        return weather;
    }

    /**
     * Create a Chainlink request to retrieve API response, find the target
     * data, then multiply by 1000000000000000000 (to remove decimal places from data).
     */
    function requestWeather() public returns (bytes32 requestId) 
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        
        // Set the URL to perform the GET request on
        // https://api.openweathermap.org/data/2.5/weather?id=5391959&appid=60c410e380bce538ecb359dd84ae70e7
        request.add("get", string(abi.encodePacked("https://api.openweathermap.org/data/2.5/weather?id=",cityToCityId[city],"&appid=",apiKey)));
        request.add("copyPath", "weather.0.main");

        // Sends the request
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    /**
     * Receive the response in the form of uint256
     */ 
    function fulfill(bytes32 _requestId, bytes32 _weather) public recordChainlinkFulfillment(_requestId)
    {
        weather = bytes32ToString(_weather);
    }

    // function withdrawLink() external {} - Implement a withdraw function to avoid locking your LINK in the contract
    function bytes32ToString(bytes32 _bytes32) public pure returns (string memory) {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }
}

