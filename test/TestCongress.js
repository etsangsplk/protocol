const MyCongress = artifacts.require('Congress.sol');
var Configuration = artifacts.require('Configuration.sol');
var Registry = artifacts.require('registries/ProposalRegistry.sol');
var VotingStrategy = artifacts.require('./mock/VotingStrategyMock.sol');
var VotingRights = artifacts.require('voting/WhitelistRights.sol');
var Manager = artifacts.require('managers/ProposalManager.sol');
var Proposal = artifacts.require('./mock/ProposalMock.sol');

const utils = require('./helpers/Utils.js');

let congress, config, repo, factory, manager;

contract('Congress', function (accounts) {

    let shouldntFail = function (err) {
        assert.isFalse(!!err);
    };

    beforeEach(async () => {
        config = await Configuration.new();
        repo = await Registry.new();
        let votingStrategy = await VotingStrategy.new();
        let votingRights = await VotingRights.new([accounts[0]]);
        let manager = await Manager.new();

        await repo.add(
            "foo",
            Proposal.binary,
            "0x0"
        );
        congress = await MyCongress.new(
            config.address,
            repo.address,
            manager.address,
            votingRights.address,
            votingStrategy.address
         );

         await manager.transferOwnership(congress.address);
    });

    it('should allow me to propose', async () => {
        let result = await congress.propose(
            "foo",
            ""
        );

        assert.equal(result.logs[0].event, 'ProposalCreated', 'proposal was not added');
    });

});
