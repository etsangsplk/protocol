const MyVersion = artifacts.require('Version/Version.sol');
const MyOrganizationFactory = artifacts.require('Factories/OrganizationFactory.sol');
const MyVotingPower = artifacts.require('./mocks/VotingPowerMock.sol');
const MyVotingRights = artifacts.require('./mocks/VotingRightsMock.sol');

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
            votingRights.address,
            votingPower.address
        );

        assert.equal(result.logs[0].event, 'OrganizationCreated', 'organization not created');
    });

});
