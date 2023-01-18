// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./perms.sol";
import "./hackerpass.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract HackerPassDeployer is HackerPassPermissions {
  using Counters for Counters.Counter;
  Counters.Counter private _contractCounter;

  struct DeployedContractInfo {
    uint256 id;
    address contractAddress;
    string name;
    string symbol;
    string mintURI;
  }

  DeployedContractInfo[] public deployedContracts;

  function deployContract(string memory name, string memory symbol, string memory mintURI) public onlyAdmin {
    HackerPass hackerPass = new HackerPass(name, symbol, mintURI, msg.sender);
    deployedContracts.push(DeployedContractInfo({
      id: _contractCounter.current(),
      contractAddress: address(hackerPass),
      name: name,
      symbol: symbol,
      mintURI: mintURI
    }));
    _contractCounter.increment();
  }

}