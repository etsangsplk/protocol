# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [unreleased]

### Added
 - ```hasWinner``` function in Electoral System contract
 - ```topCandidates``` function in Electoral System contract
 - Ability for multiple voting rounds

### Changed
 - pragma version updated to ```^0.4.18```

### Removed

## [0.2.0] - 2017-12-03

### Added
 - Creation block to proposal, to allow for easier usage with [stakebank](https://github.com/harbourproject/stakebank)
 - Unvote function

### Changed
 - Bug fix related to proposal times
 - Voting function checking proposal times
 - Passing proposal to VotingRights & Power functions
 - Update to quorum counting
 - Replaced ```quorumReached``` with ```maximumQuorum```
 - Electoral System Methods
 - Moved Voting Manager functions into ballot
 
### Removed
 - Vault 
 - Voting Manager

## [0.1.0] - 2017-11-09

### Added
 - Added core protocol contracts
 - Migration scripts
 - Truffle configuration files
 - Javascript test files
 - package.json
 - Solium files
 - Travis configuration
