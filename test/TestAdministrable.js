const Administrable = artifacts.require('administrable.sol');

contract('administrable', function (accounts) {

    let administrable;

    beforeEach(async () => {
        administrable = await Administrable.new();
    });

    it('should allow owner to add admin', async () => {
        await administrable.addAdmin(accounts[1]);
        assert.equal(true, await administrable.isAdmin.call(accounts[1]), 'admin was not added');
    });

    it('should allow owner to remove admin', async () => {
        await administrable.addAdmin(accounts[1]);
        assert.equal(true, await administrable.isAdmin.call(accounts[1]), 'admin was not set');
        await administrable.removeAdmin(accounts[1]);
        assert.equal(false, await administrable.isAdmin.call(accounts[1]), 'admin was not removed');
    })

});
