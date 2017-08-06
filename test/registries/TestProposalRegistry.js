const ProposalRegistry = artifacts.require('registries/ProposalRegistry.sol');
var ExecutorMock = artifacts.require("mocks/ExecutorMock.sol");
var ProposalFactory = artifacts.require("factories/ProposalFactoryInterface.sol");

let registry;

contract('ProposalRegistry', function (accounts) {

        let shouldntFail = function (err) {
            assert.isFalse(!!err);
        };

        beforeEach(async () => {
            registry = await ProposalRegistry.new();
        });

        it('verifies that proposal can be added to registry', async () => {

            let executor = await ExecutorMock.new();
            let factory = await ProposalFactory.new();

            let result = await registry.add(
                "foo",
                executor.address,
                factory.address,
                "foo"
            );

            assert.equal(result.logs[0].event, 'ProposalAdded', 'proposal was not added');
        });

        it('returns proposal data', async () => {
            let result = await registry.get.call("foo");
            assert.isNotNull(result);
        });

        it('removes proposal data', async () => {
            let result = await registry.remove("foo");
            assert.equal(result.logs[0].event, 'ProposalRemoved', 'proposal was not added');
        });
});
