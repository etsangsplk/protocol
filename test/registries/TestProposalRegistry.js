const ProposalRegistry = artifacts.require('registries/ProposalRegistry.sol');

let registry;

contract('ProposalRegistry', function (accounts) {

        let shouldntFail = function (err) {
            assert.isFalse(!!err);
        };

        beforeEach(async () => {
            registry = await ProposalRegistry.new();
        });

        it('verifies that proposal can be added to registry', async () => {

            let result = await registry.add(
                "foo",
                "0x0",
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
