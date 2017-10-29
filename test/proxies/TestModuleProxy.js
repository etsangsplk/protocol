const MyModuleProxy = artifacts.require('Proxies/ModuleProxy.sol');
const AddressResolver = artifacts.require('./../mocks/AddrResolverMock.sol');
const Configuration = artifacts.require('Configuration.sol');

contract('ModuleProxy', function () {

    let proxy, resolver, config;

    beforeEach(async () => {

        let name = 0x8283b36898b5e926c2734d82f3b5f29c728bebd0ace60f5a8a56f9977a50313d;
        resolver = await AddressResolver.new();
        config = await Configuration.new();

        await resolver.addRecord(name, config.address);

        proxy = await MyModuleProxy.new(resolver.address, name);
    });

    it('should set data on proxy storage', async () => {
        let key = "foo";
        let value = 12;

        let configProxy = Configuration.at(proxy.address);

        await configProxy.set(key, value);

        assert.equal(await configProxy.get.call(key), value, 'value was not set on proxy');
        assert.notEqual(await config.get.call(key), value, 'value was set on configuration');
    })

});
