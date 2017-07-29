const ProposalRepository = artifacts.require('repositories/ProposalRepository.sol');
var ExecutorMock = artifacts.require("mocks/ExecutorMock.sol");
var ProposalFactory = artifacts.require("factories/ProposalFactoryInterface.sol");

let repository;

contract('ProposalRepository', function (accounts) {

        let shouldntFail = function (err) {
            assert.isFalse(!!err);
        };

        beforeEach(async () => {
            repository = await ProposalRepository.new();
        });

        it('verifies that proposal can be added to repository', async () => {

            let executor = await ExecutorMock.new();
            let factory = await ProposalFactory.new();

            let result = await repository.add(
                "foo",
                executor.address,
                factory.address
            );

            assert.equal(result.logs[0].event, 'ProposalAdded', 'proposal was not added');
        });

        it('returns proposal data', async () => {
            let result = await repository.get.call("foo");
            assert.isNotNull(result);
        });

        it('removes proposal data', async () => {
            let result = await repository.remove("foo");
            assert.equal(result.logs[0].event, 'ProposalRemoved', 'proposal was not added');
        });
});
