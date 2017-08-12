const SafeMath = artifacts.require('./SafeMath.sol');
const Version = artifacts.require("./Version.sol");

module.exports = async (deployer) => {
  deployer.deploy(Version);
};
