// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MediaNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    struct Media {
        string metadataURI;
        string mediaHash;
    }

    mapping(uint256 => Media) public mediaData;

    event NFTMinted(uint256 tokenId, string metadataURI, string mediaHash);

    constructor() ERC721("MediaNFT", "MNFT") {}

     function safeMint(address to, string memory metadataURI, string memory mediaHash) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        mediaData[tokenId] = Media(metadataURI, mediaHash);
        emit NFTMinted(tokenId, metadataURI, mediaHash);
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        ownerOf(tokenId); // This will revert if the token doesn't exist
        return mediaData[tokenId].metadataURI;
    }

    function getMediaHash(uint256 tokenId) public view returns (string memory) {
        ownerOf(tokenId); // This will revert if the token doesn't exist
        return mediaData[tokenId].mediaHash;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
      ownerOf(tokenId); // This will revert if the token doesn't exist
        return mediaData[tokenId].metadataURI;
    }
}