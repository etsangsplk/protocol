# Harbour Protocol

[![Build Status](https://travis-ci.org/HarbourProject/protocol.svg?branch=development)](https://travis-ci.org/HarbourProject/protocol) [![License](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)

[Harbour](https://harbourproject.io) is a protocol designed to make governance easy through modularized infrastructure that defines a set of base rules tailored to specific types of organizations. This repository contains the smart contracts for the Harbours on-chain protocol. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Installing

The Harbour Protocol uses npm to manage dependencies, therefore the installation process is kept simple:

```
npm install
```

### Running tests

The Harbour Protocol uses truffle for its ethereum development environment. All tests can be run using truffle:

```
truffle test
```

Using the report argument will enable the ethereum gas reporter, this prints all gas used by functions:

```
truffle test --report
```

To run linting, use solium:

```
solium --dir ./contracts
```

## Built With
* [Truffle](https://github.com/trufflesuite/truffle) - Ethereum development environment 

## Authors

* **Dean Eigenmann** - [decanus](https://github.com/decanus)

See also the list of [contributors](https://github.com/HarbourProject/protocol/contributors) who participated in this project.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/HarbourProject/protocol/tags).

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details
