// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract JsNft is ERC721Enumerable {
    // Updated with your IPFS CID for the metadata
    string public constant TOKEN_URI = "ipfs://QmZRBz5Y75xhtxzkfTygxyG5LSYcxsEeFYXrK7rbDv2Gag";
    uint256 private s_tokenCounter;
    uint256 public royaltyBps = 250; // Royalty rate in basis points (2.5% = 250)
    address public creator;

    constructor() ERC721("JS", "JS") {
        s_tokenCounter = 0;
        creator = msg.sender; // Setting the creator as the person who deployed the contract
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);  
        s_tokenCounter = s_tokenCounter + 1;
    }


    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return TOKEN_URI;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

    function royaltyInfo(uint256 _tokenId, uint256 _salePrice) external view returns (address receiver, uint256 royaltyAmount) {
        // For simplicity, always returning the creator as the recipient of the royalties
        uint256 _royalty = (_salePrice * royaltyBps) / 10000;
        return (creator, _royalty);
    }
}
