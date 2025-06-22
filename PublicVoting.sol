// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PublicVoting {
    address public owner;
    uint public votingDeadline;

    struct Candidate {
        string name;
        uint voteCount;
    }

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    bool public votingStarted;
    bool public votingEnded;

    event CandidateAdded(string name);
    event VoteCasted(address voter, uint candidateIndex);
    event VotingStarted(uint deadline);
    event VotingEnded();

    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    modifier onlyDuringVoting() {
        require(votingStarted && !votingEnded, "Voting not active");
        require(block.timestamp <= votingDeadline, "Voting time is over");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory _name) external onlyOwner {
        require(!votingStarted, "Cannot add candidates after voting starts");
        candidates.push(Candidate(_name, 0));
        emit CandidateAdded(_name);
    }

    function startVoting(uint _durationInSeconds) external onlyOwner {
        require(candidates.length > 0, "Add candidates first");
        votingStarted = true;
        votingDeadline = block.timestamp + _durationInSeconds;
        emit VotingStarted(votingDeadline);
    }

    function vote(uint _candidateIndex) external onlyDuringVoting {
        require(!hasVoted[msg.sender], "Already voted");
        require(_candidateIndex < candidates.length, "Invalid candidate index");

        candidates[_candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
        emit VoteCasted(msg.sender, _candidateIndex);
    }

    function endVoting() external {
        require(votingStarted, "Voting not started");
        require(block.timestamp > votingDeadline, "Voting still ongoing");
        votingEnded = true;
        emit VotingEnded();
    }

    function getCandidateCount() public view returns (uint) {
        return candidates.length;
    }

    function getCandidate(uint index) public view returns (string memory name, uint voteCount) {
        require(index < candidates.length, "Invalid index");
        Candidate memory c = candidates[index];
        return (c.name, c.voteCount);
    }

    function getWinningCandidate() public view returns (string memory winnerName, uint winningVoteCount) {
        require(votingEnded, "Voting still in progress");

        uint maxVotes = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        return (candidates[winnerIndex].name, maxVotes);
    }
}
