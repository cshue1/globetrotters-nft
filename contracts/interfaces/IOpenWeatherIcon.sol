pragma solidity ^0.6.6;

interface IOpenWeatherIcon {
  function weather() external view returns (string memory);
  function setCity() external view;
  function city() external view returns (string memory);
} 