const MyNFT = artifacts.require("MyNFT");
const Purchase = artifacts.require("Purchase");
const MyTokenERC20 = artifacts.require("MyTokenERC20 ");

module.exports = function (deployer) {
    deployer.deploy(MyNFT);
    deployer.deploy(Purchase);
    deployer.deploy(MyTokenERC20);
};
