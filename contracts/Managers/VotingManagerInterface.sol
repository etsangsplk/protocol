pragma solidity 0.4.18;

interface VotingManagerInterface {

    function vote(uint proposal, address voter, uint choice, uint256 weight) external;
    function votes(uint proposal, uint choice) external view returns (uint256);
    function voted(uint proposal, address voter) public view returns (bool);
    function quorum(uint proposal) public view returns (uint256);

}
