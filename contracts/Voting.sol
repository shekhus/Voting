pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract Voting {
  mapping(address => bool) public voters;
  struct Choice {
    uint id;
    string name;
    uint votes;
  }
  struct Ballot {
    uint id;
    string name;
    Choice[] choices;
    uint end;
  }
  mapping(uint => Ballot) public ballots;
  uint public nextBallotId;
  address public admin;
  mapping(address => mapping(uint => bool)) public votes;
  
  constructor() public {
    admin = msg.sender;
  }

  function getBallot(uint id) external view returns(Ballot memory) {
    return ballots[id];
  }
  
  function addVoters(address[] calldata _voters) external onlyAdmin() {
    for(uint i = 0; i < _voters.length; i++) {
        voters[_voters[i]] = true;
    }
  }

   function createBallot(
    string memory name,
    string[] memory _choices,
    uint offset
    ) public onlyAdmin() {
      //create a new Ballot struct and insert it in a mapping ballots
      ballots[nextBallotId].id = nextBallotId;
      ballots[nextBallotId].name = name;
      //now =current time e.g 1pm, offset =3600 (1hr) =timestamp for 2.00pm
      ballots[nextBallotId].end = block.timestamp + offset;
      //we neet to loop thru Choices array and populate the choices array in the function (choices field of Ballot Struct)
      for(uint i = 0; i < _choices.length ; i++) {
        ballots[nextBallotId].choices.push(Choice(i, _choices[i], 0));
      }
      nextBallotId++;
  }
  function vote(uint ballotId, uint choiceId) external {
      //check to make sure that a person sending trx is voter 
    require(voters[msg.sender] == true, 'only voters can vote');
     //voter has not voted earlie
    require(votes[msg.sender][ballotId] == false, 'voter can only vote once for a ballot');
      //make sure that ballot han not already ended 
    require(block.timestamp < ballots[ballotId].end, 'can only vote until ballot end date');
    votes[msg.sender][ballotId] = true;
    ballots[ballotId].choices[choiceId].votes++;
  }
  //If `pragma experimental ABIEncoderV2`
  function results(uint ballotId) 
    view 
    external 
    returns(Choice[] memory) {
    require(block.timestamp >= ballots[ballotId].end, 'cannot see the ballot result before ballot end');
    return ballots[ballotId].choices;
  }

  //If no `pragma experimental ABIEncoderV2`
  //function results(uint ballotId) 
  //  view 
  //  external 
  //  returns(uint[] memory, string[] memory, uint[]memory) {
  //  require(now >= ballots[ballotId].end, 'can only see result after ballot end');
  //  Choice[] storage choices = ballots[ballotId].choices;
  //  uint[] memory ids = new uint[](choices.length);
  //  string[] memory names = new string[](choices.length);
  //  uint[] memory votes = new uint[](choices.length);
  //  for(uint i = 0; i < choices.length; i++) {
  //    ids[i] = choices[i].id;
  //    names[i] = choices[i].name;
  //    votes[i] = choices[i].votes;
  //  }
  //  return(ids, names, votes);
  //}

  modifier onlyAdmin() {
    require(msg.sender == admin, 'only admin');
    _;
  }
}
