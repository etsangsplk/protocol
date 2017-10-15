const Version = artifacts.require("./Version.sol");
const OrganizationFactory = artifacts.require("./factories/OrganizationFactory.sol");

module.exports = async (deployer) => {
    deployer.deploy(OrganizationFactory)
        .then(() => deployer.deploy(Version, OrganizationFactory.address));
};
