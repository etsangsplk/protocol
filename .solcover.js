const tokens = require('glob').sync('contracts/Tokens/*.sol').map(n => n.replace('contracts/', ''));
const interfaces = require('glob').sync('contracts/*/*Interface.sol').map(n => n.replace('contracts/', ''));
const ens = require('glob').sync('contracts/ENS/*.sol').map(n => n.replace('contracts/', ''));
const stdlib = [
    'Ownership/Ownable.sol',
    'ConfigurationInterface.sol',
    'Proposals/Ballot/BallotInterface.sol',
    'OrganizationInterface.sol',
    'Migrations.sol',
    'SafeMath.sol'
];

module.exports = {
    norpc: true,
    skipFiles: tokens.concat(interfaces).concat(stdlib).concat(ens),
    copyNodeModules: false,
};
