// We are going to skip a bit on these tests...

const { assert } = require("chai")
const { network, deployments, ethers } = require("hardhat")
const { developmentChains } = require("../../helper-hardhat-config")

//writing the test code from here..

!developmentChains.includes(network.name)
  ? describe.skip
  : describe("JS NFT Unit Tests", function () {
    let jsNft, deployer

    beforeEach(async () => {
      accounts = await ethers.getSigners()
      deployer = accounts[0]
      await deployments.fixture(["jsnft"])
      jsNft = await ethers.getContract("JsNft")
    })

    describe("Constructor", () => {
      it("Initializes the NFT Correctly.", async () => {
        const name = await jsNft.name()
        const symbol = await jsNft.symbol()
        const tokenCounter = await jsNft.getTokenCounter()
        assert.equal(name, "JS NFT")
        assert.equal(symbol, "JS")
        assert.equal(tokenCounter.toString(), "0")
      })
    })
    //test02
    describe("Mint NFT", () => {
      beforeEach(async () => {
        const txResponse = await jsNft.mintNft()
        await txResponse.wait(1)
      })
      it("Allows users to mint an NFT, and updates appropriately", async function () {
        const tokenURI = await jsNft.tokenURI(0)
        const tokenCounter = await jsNft.getTokenCounter()

        assert.equal(tokenCounter.toString(), "1")
        assert.equal(tokenURI, await jsNft.TOKEN_URI())
      })
      it("Show the correct balance and owner of an NFT", async function () {
        const deployerAddress = deployer.address;
        const deployerBalance = await jsNft.balanceOf(deployerAddress)
        const owner = await jsNft.ownerOf("0")

        assert.equal(deployerBalance.toString(), "1")
        assert.equal(owner, deployerAddress)
      })
    })
  })
