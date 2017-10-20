const MyOrganization = artifacts.require('Organization.sol');
var Configuration = artifacts.require('Configuration.sol');
var VotingPower = artifacts.require('./mock/VotingPowerMock.sol');
var VotingRights = artifacts.require('./mock/VotingRightsMock.sol');
var ProposalManager = artifacts.require('managers/ProposalManager.sol');
var VotingManager = artifacts.require('managers/VotingManager.sol');
var MyModuleRegistry = artifacts.require('registries/ModuleRegistry.sol');
var Ballot = artifacts.require('proposals/ballot/Ballot.sol');
var Proposal = artifacts.require('proposals/Proposal.sol');
const utils = require('./helpers/Utils.js');

contract('Organization', function (accounts) {

    let organization, config, proposalManager, votingRights;

    beforeEach(async () => {
        config = await Configuration.new();
        proposalManager = await ProposalManager.new();
        votingRights = await VotingRights.new();

        let votingPower = await VotingPower.new();
        let votingManager = await VotingManager.new();
        let moduleRegistry = await MyModuleRegistry.new();

        await moduleRegistry.addModule("rights", votingRights.address, "0x0");
        await moduleRegistry.addModule("strategy", votingPower.address, "0x0");

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

        it('should fail when voting without rights', async () => {
            await organization.approve(0, { from: accounts[0] });
            assert.equal(await proposalManager.isApproved.call(0), true);
            await votingRights.addVoter(accounts[1]);

            try {
                await organization.vote(0, 1, { from: accounts[1] });
            } catch (error) {
                return utils.ensureException(error);
            }

            assert.fail('voting did not fail');
        });
    });

});
