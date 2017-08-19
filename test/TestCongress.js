const MyCongress = artifacts.require('Congress.sol');
var Configuration = artifacts.require('Configuration.sol');
var Registry = artifacts.require('registries/ProposalRegistry.sol');
var VotingStrategy = artifacts.require('./mock/VotingStrategyMock.sol');
var VotingRights = artifacts.require('voting/WhitelistRights.sol');
var Proposal = artifacts.require('proposals/Proposal.sol');

const utils = require('./helpers/Utils.js');

let congress, config, repo, factory;

contract('Congress', function (accounts) {

    let shouldntFail = function (err) {
        assert.isFalse(!!err);
    };

    beforeEach(async () => {
        config = await Configuration.new();
        repo = await Registry.new();
        let votingStrategy = await VotingStrategy.new();
        let votingRights = await VotingRights.new([accounts[0]]);

        await repo.add(
            "foo",
            Proposal.binary,
            "0x0"
        );
        congress = await MyCongress.new(
            config.address,
            repo.address,
            votingRights.address,
            votingStrategy.address
         );
    });

    it('should allow me to propose', async () => {
        let result = await congress.propose(
            "foo",
            "0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002"
        );

        assert.equal(result.logs[0].event, 'ProposalCreated', 'proposal was not added');
    });

});
