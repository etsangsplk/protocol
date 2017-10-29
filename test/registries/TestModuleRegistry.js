const MyModuleRegistry = artifacts.require('Registries/ModuleRegistry.sol');

contract('ModuleRegistry', function (accounts) {

    let moduleRegistry;

    beforeEach(async () => {
        moduleRegistry = await MyModuleRegistry.new();
    });

    it('should return correct address', async () => {
        let name = "foo";
        let address = accounts[1];

        await moduleRegistry.addModule(name, address);
        assert.equal(address, await moduleRegistry.getModule.call(name));
    });
});
