// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract USElection {
    struct Candidate {
        string name;
        string description;
        uint256 voteCount;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    uint256 public candidateCount;

    constructor() {
        candidateCount = 0;
    }

    function addCandidate(string memory _name, string memory _description) public {
        candidateCount++;
        candidates[candidateCount] = Candidate({
            name: _name,
            description: _description,
            voteCount: 0
        });
    } //  ← this was missing

    function vote(uint256 _candidateID) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateID > 0 && _candidateID <= candidateCount, "Invalid candidate ID");

        candidates[_candidateID].voteCount++;
        hasVoted[msg.sender] = true;
    }

    function getWinner() public view returns (string memory winnerName, uint256 totalVotes) {
        require(candidateCount > 0, "No candidates available");

        uint256 highestVotes = 0;
        uint256 winnerID = 0;

        for (uint256 i = 1; i <= candidateCount; i++) {
            if (candidates[i].voteCount > highestVotes) {
                highestVotes = candidates[i].voteCount;
                winnerID = i;
            }
        }

        winnerName = candidates[winnerID].name;
        totalVotes = candidates[winnerID].voteCount;
    }
}
//Quick Bug Fix:Initialize winnerID = 1 (assume first candidate by default), and start loop from i = 2.
//since candidates[0] does not exist











