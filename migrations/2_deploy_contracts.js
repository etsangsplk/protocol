const Version = artifacts.require("./Version.sol");
const OrganizationFactory = artifacts.require("./Factories/OrganizationFactory.sol");

module.exports = async (deployer) => {
    deployer.deploy(OrganizationFactory)
        .then(() => deployer.deploy(Version, OrganizationFactory.address));
};
