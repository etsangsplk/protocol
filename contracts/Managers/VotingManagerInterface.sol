pragma solidity 0.4.18;

interface VotingManagerInterface {

    function vote(uint proposal, address voter, uint choice, uint weight) external;
    function unvote(uint proposal, address voter) external;
    function votes(uint proposal, uint choice) external view returns (uint);
    function voted(uint proposal, address voter) public view returns (bool);
    function quorum(uint proposal) public view returns (uint);

}
