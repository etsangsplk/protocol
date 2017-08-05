const SafeMath = artifacts.require('./SafeMath.sol');
const Configuration = artifacts.require("./Configuration.sol");

module.exports = async (deployer) => {
  deployer.deploy(Configuration);
};
