// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// [...]

contract Voting {
  uint public constant MAX_VOTES_PER_VOTER = 100;

  struct Movie {
    uint id;
    string title; //pollId (1, 2, 3 ...)
    string cover; //optionName 
    uint votes;
  }

  event Voted ();
  event NewMovie ();

  mapping(uint => Movie) public movies;
  uint public moviesCount;

  mapping(address => uint) public votes;

  constructor() {
    moviesCount = 0;
  }

  function vote(uint _movieID) public {
    require(votes[msg.sender] < MAX_VOTES_PER_VOTER, "Voter has no votes left.");
    require(_movieID > 0 && _movieID <= moviesCount, "Movie ID is out of range.");

    votes[msg.sender]++;
    movies[_movieID].votes++;

    emit Voted();
  }

  function addMovie(string memory _title, string memory _cover) public {
    moviesCount++;

    Movie memory movie = Movie(moviesCount, _title, _cover, 0);
    movies[moviesCount] = movie;

    emit NewMovie();
    vote(moviesCount);
  }
}
