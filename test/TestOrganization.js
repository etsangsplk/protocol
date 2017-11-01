const MyOrganization = artifacts.require('Organization.sol');
var Configuration = artifacts.require('Configuration.sol');
var VotingPower = artifacts.require('./mock/VotingPowerMock.sol');
var VotingRights = artifacts.require('./mock/VotingRightsMock.sol');
var ProposalManager = artifacts.require('Managers/ProposalManager.sol');
var VotingManager = artifacts.require('Managers/VotingManager.sol');
var MyModuleRegistry = artifacts.require('Registries/ModuleRegistry.sol');
var Ballot = artifacts.require('Proposals/Ballot/Ballot.sol');
var Proposal = artifacts.require('Proposals/Proposal.sol');
const utils = require('./helpers/Utils.js');

contract('Organization', function (accounts) {

    let organization, config, proposalManager, votingRights, votingManager;

    beforeEach(async () => {
        config = await Configuration.new();
        proposalManager = await ProposalManager.new();
        votingManager = await VotingManager.new();
        votingRights = await VotingRights.new();

        let votingPower = await VotingPower.new();
        let moduleRegistry = await MyModuleRegistry.new();

        await moduleRegistry.addModule("rights", votingRights.address);
        await moduleRegistry.addModule("strategy", votingPower.address);

        organization = await MyOrganization.new(
            config.address,
            proposalManager.address,
            votingManager.address,
            moduleRegistry.address
        );

         await proposalManager.transferOwnership(organization.address);
         await votingManager.transferOwnership(organization.address);
    });

    context('voting', async () => {

        let ballot;

        beforeEach(async () => {
            ballot = await Ballot.new(["0x0"], ["0x0"], [true]);
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

        it('should fail when voting without rights', async () => {
            await organization.approve(0, { from: accounts[0] });
            assert.equal(await proposalManager.isApproved.call(0), true);

            try {
                await organization.vote(0, 0, { from: accounts[1] });
            } catch (error) {
                return utils.ensureException(error);
            }

            assert.fail('voting did not fail');
        });

        it('should fail when voting with invalid choice', async () => {
            await organization.approve(0, { from: accounts[0] });
            assert.equal(await proposalManager.isApproved.call(0), true);
            await votingRights.addVoter(accounts[1]);

            let choice = 1;
            assert.equal(await ballot.isValidChoice.call(1), false);

            try {
                await organization.vote(0, choice, { from: accounts[1] });
            } catch (error) {
                return utils.ensureException(error);
            }

            assert.fail('voting did not fail');
        });

        it('should allow organization member to vote', async () => {
            await organization.approve(0, { from: accounts[0] });
            assert.equal(await proposalManager.isApproved.call(0), true);

            await votingRights.addVoter(accounts[1]);
            await organization.vote(0, 0, { from: accounts[1] });

            assert.equal(await votingManager.voted.call(0, accounts[1]), true);
        });
    });

});
