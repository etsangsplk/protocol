const MyModuleRegistry = artifacts.require('Registries/ModuleRegistry.sol');

contract('ModuleRegistry', function (accounts) {

    let moduleRegistry;

    beforeEach(async () => {
        moduleRegistry = await MyModuleRegistry.new();
    });

    context('getters', async () => {

        let name;
        let hash;
        let address;

        beforeEach(async () => {
            name = "foo";
            hash = "0x0000000000000000000000000000000000000000000000000000000000000000";
            address = accounts[1];

            moduleRegistry.addModule(name, address, hash);
        });

        it('should return correct address', async () => {
            assert.equal(address, await moduleRegistry.getModule.call(name));
        });

        it('should return correct hash', async () => {
            assert.equal(hash, await moduleRegistry.getHash.call(name));
        });

    })
});
