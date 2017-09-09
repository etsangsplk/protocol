const MyOrganization = artifacts.require('Organization.sol');
var Configuration = artifacts.require('Configuration.sol');
var Registry = artifacts.require('registries/ProposalRegistry.sol');
var VotingStrategy = artifacts.require('./mock/VotingStrategyMock.sol');
var VotingRights = artifacts.require('./mock/VotingRightsMock.sol');
var ProposalManager = artifacts.require('managers/ProposalManager.sol');
var VotingManager = artifacts.require('managers/VotingManager.sol');
var Proposal = artifacts.require('./mock/ProposalMock.sol');

const utils = require('./helpers/Utils.js');

let organization, config, repo, factory, proposalManager;

contract('Organization', function (accounts) {

    let shouldntFail = function (err) {
        assert.isFalse(!!err);
    };

    beforeEach(async () => {
        config = await Configuration.new();
        repo = await Registry.new();
        let votingStrategy = await VotingStrategy.new();
        let votingRights = await VotingRights.new([accounts[0]]);
        let proposalManager = await ProposalManager.new();
        let votingManager = await VotingManager.new();

        await repo.add(
            "foo",
            Proposal.binary,
            "0x0"
        );
        organization = await MyOrganization.new(
            config.address,
            repo.address,
            proposalManager.address,
            votingManager.address,
            votingRights.address,
            votingStrategy.address
         );

         await proposalManager.transferOwnership(organization.address);
         await votingManager.transferOwnership(organization.address);
    });

    it('should allow me to propose', async () => {
        let result = await organization.propose(
            "foo",
            ""
        );

        assert.equal(result.logs[0].event, 'ProposalCreated', 'proposal was not added');
    });

});
