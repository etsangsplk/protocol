const MyVersion = artifacts.require('version/Version.sol');
var VotingStrategyInterface = artifacts.require('./mock/VotingStrategyMock.sol');
var VotingRightsInterface = artifacts.require('./mock/VotingRightsMock.sol');

contract('Version', function (accounts) {

    let version;

    beforeEach(async () => {
        version = await MyVersion.new();
    });

    it('should allow me to create a organization', async () => {
        let votingStrategy = await VotingStrategyInterface.new();
        let votingRights = await VotingRightsInterface.new([accounts[0]]);

        let result = await version.createOrganization(
            votingRights.address,
            votingStrategy.address
        );

        assert.equal(result.logs[0].event, 'OrganizationCreated', 'organization not created');
    });

});
