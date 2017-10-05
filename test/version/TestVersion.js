const MyVersion = artifacts.require('version/Version.sol');
var MyVotingPower = artifacts.require('./mock/VotingPowerMock.sol');
var VotingRightsInterface = artifacts.require('./mock/VotingRightsMock.sol');

contract('Version', function (accounts) {

    let version;

    beforeEach(async () => {
        version = await MyVersion.new();
    });

    it('should allow me to create a organization', async () => {
        let votingPower = await MyVotingPower.new();
        let votingRights = await VotingRightsInterface.new([accounts[0]]);

        let result = await version.createOrganization(
            votingRights.address,
            votingPower.address
        );

        assert.equal(result.logs[0].event, 'OrganizationCreated', 'organization not created');
    });

});
