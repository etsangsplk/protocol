const MyVoting = artifacts.require('voting/Voting.sol');

let voting;
contract('Voting', function (accounts) {

    let shouldntFail = function (err) {
        assert.isFalse(!!err);
    };

    beforeEach(async () => {
        voting = await MyVoting.new();
    });

    it('should allow me to approve proposals', async () => {
        await voting.create(0x0, 0x0);
        assert.equal(false, await voting.isApproved.call(0));
        await voting.approve(0);
        assert.equal(true, await voting.isApproved.call(0), 'proposal not approved');
    })

});
