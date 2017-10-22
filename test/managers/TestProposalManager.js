const MyProposalManager = artifacts.require('Managers/ProposalManager.sol');

contract('ProposalManager', function (accounts) {

    let proposalManager;

    beforeEach(async () => {
        proposalManager = await MyProposalManager.new();
    });

    it('should allow owner to add a proposal', async () => {
       await proposalManager.add(accounts[1], accounts[3]);
       assert.equal(accounts[3], await proposalManager.getProposal.call(0), 'proposal address did not match expected value');
    });


    it('should allow owner to approve a proposal', async () => {
       await proposalManager.add(accounts[1], accounts[3]);
       assert.equal(false, await proposalManager.isApproved.call(0), 'proposal was not expected to be approved');
       await proposalManager.approve(0);
       assert.equal(true, await proposalManager.isApproved.call(0), 'proposal was not approved');
    });

});
