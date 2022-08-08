const Migrations = artifacts.require("Migrations");  //grabs migrations abis  

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
