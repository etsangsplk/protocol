const MyOrganization = artifacts.require('Organization.sol');
const Configuration = artifacts.require('Configuration.sol');
const VotingPower = artifacts.require('./mocks/VotingPowerMock.sol');
const VotingRights = artifacts.require('./mocks/VotingRightsMock.sol');
const ProposalManager = artifacts.require('Managers/ProposalManager.sol');
const MyModuleRegistry = artifacts.require('Registries/ModuleRegistry.sol');
const Ballot = artifacts.require('Proposals/Ballot/Ballot.sol');
const Proposal = artifacts.require('Proposals/Proposal.sol');
const utils = require('./helpers/Utils.js');

contract('Organization', function (accounts) {

    let organization, config, proposalManager, votingRights;

    beforeEach(async () => {
        config = await Configuration.new();
        proposalManager = await ProposalManager.new();
        votingRights = await VotingRights.new();

        let votingPower = await VotingPower.new();
        let moduleRegistry = await MyModuleRegistry.new();

        await moduleRegistry.addModule("rights", votingRights.address);
        await moduleRegistry.addModule("strategy", votingPower.address);

        organization = await MyOrganization.new(
            config.address,
            proposalManager.address,
            moduleRegistry.address
        );

         await proposalManager.transferOwnership(organization.address);
    });

    context('voting', async () => {

        let ballot;

        beforeEach(async () => {
            ballot = await Ballot.new(["0x0"], ["0x0"], [true]);
            await ballot.transferOwnership(organization.address);

            let now = Math.floor(Date.now() / 1000);

            let proposal = await Proposal.new(ballot.address, false, now * 0.75, now * 1.5);
            await organization.propose(proposal.address);
        });

        it('should fail when voting on unapproved proposal', async () => {
            assert.equal(await proposalManager.isApproved.call(0), false);

            try {
                await organization.vote(0, 1, '0x0', { from: accounts[1] });
            } catch (error) {
                return utils.ensureException(error);
            }

            assert.fail('voting did not fail');
        });

        it('should fail when voting without rights', async () => {
            await organization.approve(0, { from: accounts[0] });
            assert.equal(await proposalManager.isApproved.call(0), true);

            try {
                await organization.vote(0, 0, '0x0', { from: accounts[1] });
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
                await organization.vote(0, choice, '0x0', { from: accounts[1] });
            } catch (error) {
                return utils.ensureException(error);
            }

            assert.fail('voting did not fail');
        });

        it('should allow organization member to vote', async () => {
            await organization.approve(0, { from: accounts[0] });
            assert.equal(await proposalManager.isApproved.call(0), true);

            await votingRights.addVoter(accounts[1]);
            await organization.vote(0, 0, '0x0', { from: accounts[1] });

            assert.equal(await ballot.voted.call(accounts[1]), true);
        });

        it('should allow organization member to unvote', async () => {
            let proposal = 0;
            let choice = 0;

            await organization.approve(proposal, { from: accounts[0] });
            assert.equal(await proposalManager.isApproved.call(0), true);

            await votingRights.addVoter(accounts[1]);
            await organization.vote(proposal, choice, '0x0', { from: accounts[1] });

            assert.notEqual(await ballot.votes.call(choice), 0);

            assert.equal(await ballot.voted.call(accounts[1]), true);
            await organization.unvote(0, { from: accounts[1] });
            assert.equal(await ballot.voted.call(accounts[1]), false);

            assert.equal(await ballot.votes.call(choice), 0)
        });

        it('should return expected value for quorum reached', async () => {
            let proposal = 0;
            let choice = 0;

            await config.set("minQuorum", 51 * 10**16);

            await organization.approve(proposal, { from: accounts[0] });
            assert.equal(await proposalManager.isApproved.call(0), true);

            await votingRights.addVoter(accounts[1]);
            await votingRights.addVoter(accounts[2]);

            await organization.vote(proposal, choice, '0x0', { from: accounts[1] });
            assert.equal(await organization.quorumReached.call(proposal), false);

            await organization.vote(proposal, choice, '0x0', { from: accounts[2] });
            assert.equal(await organization.quorumReached.call(proposal), true);
        });
    });
});
