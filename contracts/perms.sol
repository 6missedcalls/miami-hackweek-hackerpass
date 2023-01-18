// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract HackerPassPermissions is ReentrancyGuard {
  mapping(address => bool) public admins;

  constructor() {
    admins[msg.sender] = true;
  }

  modifier onlyAdmin() {
    require(admins[msg.sender], "Only admins can call this function.");
    _;
  }

  function addAdmin(address _admin) public onlyAdmin nonReentrant {
    admins[_admin] = true;
  }

  function removeAdmin(address _admin) public onlyAdmin nonReentrant {
    admins[_admin] = false;
  }
}