// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract HackerPass is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    string public baseURI;

    constructor(
        string memory name,
        string memory symbol,
        string memory _mintURI,
        address _owner
    ) ERC721(name, symbol) {
        baseURI = _mintURI;
        transferOwnership(_owner);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, baseURI);
    }

    // questioning life choices
    function batchMint(address to, uint256 count) public onlyOwner {
        for (uint256 i = 0; i < count; i++) {
            safeMint(to);
        }
    }

    // check for gas optimizations
    function airdropTokens(address[] memory recipients, uint256 count)
        public
        onlyOwner
    {
        for (uint256 i = 0; i < recipients.length; i++) {
            batchMint(recipients[i], count);
        }
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter.current();
    }

    // The following functions are overrides required by Solidity.
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}