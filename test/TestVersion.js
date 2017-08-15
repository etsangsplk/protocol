const MyVersion = artifacts.require('version/Version.sol');
var VotingStrategy = artifacts.require('./mock/VotingStrategyMock.sol');
var VotingRights = artifacts.require('voting/WhitelistRights.sol');

let version;

contract('Version', function (accounts) {

    let shouldntFail = function (err) {
        assert.isFalse(!!err);
    };

    beforeEach(async () => {
        version = await MyVersion.new();
    });

    it('should allow me to create a congress', async () => {
        let votingStrategy = await VotingStrategy.new();
        let votingRights = await VotingRights.new([accounts[0]]);

        let result = await version.createCongress(
            votingRights.address,
            votingStrategy.address
        );

        assert.equal(result.logs[0].event, 'CongressCreated', 'congress not created');
    });

});
