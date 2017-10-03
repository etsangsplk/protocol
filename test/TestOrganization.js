const MyOrganization = artifacts.require('Organization.sol');
var Configuration = artifacts.require('Configuration.sol');
var VotingStrategy = artifacts.require('./mock/VotingStrategyMock.sol');
var VotingRights = artifacts.require('./mock/VotingRightsMock.sol');
var ProposalManager = artifacts.require('managers/ProposalManager.sol');
var VotingManager = artifacts.require('managers/VotingManager.sol');
var Ballot = artifacts.require('proposals/ballot/Ballot.sol');
var Proposal = artifacts.require('proposals/Proposal.sol');
const utils = require('./helpers/Utils.js');

contract('Organization', function (accounts) {

    let organization, config, proposalManager;

    beforeEach(async () => {
        config = await Configuration.new();
        proposalManager = await ProposalManager.new();

        let votingStrategy = await VotingStrategy.new();
        let votingRights = await VotingRights.new([accounts[0]]);
        let votingManager = await VotingManager.new();

        organization = await MyOrganization.new(
            config.address,
            proposalManager.address,
            votingManager.address,
            votingRights.address,
            votingStrategy.address
        );

         await proposalManager.transferOwnership(organization.address);
         await votingManager.transferOwnership(organization.address);
    });

    context('voting', async () => {

        beforeEach(async () => {
            let ballot = await Ballot.new();
            let proposal = await Proposal.new(ballot.address, true, 20, 30);
            await organization.propose(proposal.address);
        });

        it('should fail when voting on unapproved proposal', async () => {
            assert.equal(await proposalManager.isApproved.call(0), false);

            try {
                await organization.vote(0, 1, { from: accounts[1] });
            } catch (error) {
                return utils.ensureException(error);
            }

            assert.fail('voting did not fail');
        });
    });

});
