const { network, ethers } = require("hardhat")

module.exports = async ({ getNamedAccounts }) => {
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId

    // Basic NFT
    const jsNft = await ethers.getContract("JsNft", deployer)
    const basicMintTx = await jsNft.mintNft()
    await basicMintTx.wait(1)
    console.log(`JS NFT index 0 tokenURI: ${await jsNft.tokenURI(0)}`)
}

module.exports.tags = ["all", "mint"]
