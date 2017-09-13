const MyVotingManager = artifacts.require('managers/VotingManager.sol');

const utils = require('./../helpers/Utils.js');

contract('VotingManager', function (accounts) {

    let votingManager;

    beforeEach(async () => {
        votingManager = await MyVotingManager.new();
    });

    it('should fail when trying to vote twice', async () => {

        await votingManager.vote(1, accounts[2], 0);

        try {
            await votingManager.vote(1, accounts[2], 0);
        } catch (error) {
            return utils.ensureException(error);
        }
    });

    it('should return choice user voted for', async () => {

        let proposal = 1;
        let choice = 12;
        let voter = accounts[2];

        await votingManager.vote(proposal, voter, choice);

        assert.equal(choice, await votingManager.choice.call(proposal, voter), 'choice did not match expected value');
    });

    it('should return if user has voted', async () => {

        let proposal = 1;
        let voter = accounts[2];

        await votingManager.vote(proposal, voter, 12);

        assert.equal(true, await votingManager.voted.call(proposal, voter), 'voted did not match expected value');
    });


});
