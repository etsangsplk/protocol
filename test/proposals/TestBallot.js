const MyBallot = artifacts.require('Proposals/Ballot/Ballot.sol');

const utils = require('./../helpers/Utils.js');

contract('Ballot', function (accounts) {

    let ballot;

    beforeEach(async () => {
        ballot = await MyBallot.new(["0x0", "0xdead"], ["0x0", "0xdead"], [true, false]);
    });

    it('should fail when trying to vote twice', async () => {

        await ballot.vote(accounts[2], 0, 1);

        try {
            await ballot.vote(accounts[2], 0, 1);
        } catch (error) {
            return utils.ensureException(error);
        }
    });

    it('should return amount of votes for option', async () => {

        let option = 12;
        let weight = 12;

        await ballot.vote(accounts[2], option, weight);

        assert.equal(weight, await ballot.votes.call(option), 'option did not match expected value');
    });

    it('should return if user has voted', async () => {

        let voter = accounts[2];

        await ballot.vote(voter, 12, 1);

        assert.equal(true, await ballot.voted.call(voter), 'voted did not match expected value');
    });

    it('should return correct value for option will accept', async () => {
        assert.equal(true, await ballot.optionWillAccept.call(0));
        assert.equal(false, await ballot.optionWillAccept.call(1));
    });

    it('should return correct value for checking if valid choice', async () => {
        assert.equal(true, await ballot.isValidChoice.call(0));
        assert.equal(false, await ballot.isValidChoice.call(2));
    });

});