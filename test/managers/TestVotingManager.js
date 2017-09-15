const MyVotingManager = artifacts.require('managers/VotingManager.sol');

const utils = require('./../helpers/Utils.js');

contract('VotingManager', function (accounts) {

    let votingManager;

    beforeEach(async () => {
        votingManager = await MyVotingManager.new();
    });

    it('should fail when trying to vote twice', async () => {

        await votingManager.vote(1, accounts[2], 0, 1);

        try {
            await votingManager.vote(1, accounts[2], 0, 1);
        } catch (error) {
            return utils.ensureException(error);
        }
    });

    it('should return amount of votes for option', async () => {

        let proposal = 1;
        let option = 12;
        let weight = 12;

        await votingManager.vote(proposal, accounts[2], option, weight);

        assert.equal(weight, await votingManager.votes.call(proposal, option), 'option did not match expected value');
    });

    it('should return if user has voted', async () => {

        let proposal = 1;
        let voter = accounts[2];

        await votingManager.vote(proposal, voter, 12, 1);

        assert.equal(true, await votingManager.voted.call(proposal, voter), 'voted did not match expected value');
    });


});
