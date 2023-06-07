const {deployProxy, upgradeProxy} = require('@openzeppelin/truffle-upgrades')
const MarketPlace = artifacts.require('MarketPlace');
module.exports = async function (deployer) {
    // const ACR_address = "0x981E8539072560d656e0aadD283a77818362c6DD";//testnet
    // const ACR_nft = "0xa15430F6EE7b29Bb27f13C88c94aa36514dAED82";//testnet

    const instanceMarketplace = await deployProxy(MarketPlace, [ACR_address, ACR_nft], {
        deployer,
        initializer: 'initialize'
    });
    console.log('instanceMarketplace address: ', instanceMarketplace.address);
}