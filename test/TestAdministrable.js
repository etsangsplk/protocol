const Administrable = artifacts.require('administrable.sol');

let administrable;

contract('administrable', function (accounts) {

    let shouldntFail = function (err) {
        assert.isFalse(!!err);
    };

    beforeEach(async () => {
        administrable = await Administrable.new();
    });

    it('should allow owner to add admin', async () => {
        let result = await administrable.addAdmin(accounts[1]);
        assert.equal(true, await administrable.isAdmin.call(accounts[1]), 'admin was not added');
    });

    it('should allow owner to remove admin', async () => {
        let result = await administrable.addAdmin(accounts[1]);
        assert.equal(true, await administrable.isAdmin.call(accounts[1]), 'admin was not set');
        result = await administrable.removeAdmin(accounts[1]);
        assert.equal(false, await administrable.isAdmin.call(accounts[1]), 'admin was not removed');
    })

});
