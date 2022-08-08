const KryptoBird = artifacts.require("KryptoBird"); 

module.exports = function(deployer) { //anonymous fxn so no name required
 deployer.deploy(KryptoBird);
};