// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract JsNft is ERC721 {
    // Updated with your IPFS CID for the metadata
    string public constant TOKEN_URI = "ipfs://QmZRBz5Y75xhtxzkfTygxyG5LSYcxsEeFYXrK7rbDv2Gag";
    uint256 private s_tokenCounter;

    constructor() ERC721("JS", "JS") {
        s_tokenCounter = 0;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return TOKEN_URI;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
