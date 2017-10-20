const MyVersion = artifacts.require('version/Version.sol');
const MyOrganizationFactory = artifacts.require('factories/OrganizationFactory.sol');
const MyVotingPower = artifacts.require('./mock/VotingPowerMock.sol');
const MyVotingRights = artifacts.require('./mock/VotingRightsMock.sol');

contract('Version', function (accounts) {

    let version;

    beforeEach(async () => {
        let factory = await MyOrganizationFactory.new();

        version = await MyVersion.new(factory.address);
    });

    it('should allow me to create a organization', async () => {
        let votingPower = await MyVotingPower.new();
        let votingRights = await MyVotingRights.new([accounts[0]]);

        let result = await version.createOrganization(
            "foo",
            votingRights.address,
            "bar",
            votingPower.address
        );

        assert.equal(result.logs[0].event, 'OrganizationCreated', 'organization not created');
    });

});
