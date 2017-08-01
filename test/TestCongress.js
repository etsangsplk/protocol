const MyCongress = artifacts.require('Congress.sol');
var Configuration = artifacts.require('Configuration.sol');
var Repository = artifacts.require('repositories/ProposalRepository.sol');
var Factory = artifacts.require('mock/ProposalFactoryMock.sol');
var Executor = artifacts.require('mock/ExecutorMock.sol');
var VotingStrategy = artifacts.require('mock/VotingStrategyMock.sol');

const utils = require('./helpers/Utils.js');

let congress, config, repo, factory;

contract('Congress', function (accounts) {

    let shouldntFail = function (err) {
        assert.isFalse(!!err);
    };

    beforeEach(async () => {
        config = await Configuration.new();
        repo = await Repository.new();
        factory = await Factory.new();
        let executor = await Executor.new();
        let votingStrategy = await VotingStrategy.new();

        await repo.add("foo", factory.address, executor.address, "0x0");
        congress = await MyCongress.new(config.address, repo.address, votingStrategy.address);
    });

    it('should allow me to propose', async () => {
        let result = await congress.propose(
            "foo",
            '0x780900dc0000000000000000000000000000000000000000000000000000000000000001'
        );

        assert.equal(result.logs[0].event, 'ProposalCreated', 'proposal was not added');
    });

});
