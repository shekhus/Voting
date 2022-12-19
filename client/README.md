App.js

1)add onSubmit={e => createBallot(e)} to the Create ballot

2)Create Create ballot function (use split for Choices array)

3) add onSubmit={e => addVoters(e)} to add voters 

4) create addVoters function

5) To ensure that only admin van add voter and admin account is set for this 
App == const [admin, setAdmin] = useState(undefined);
useEffect ==  const admin 
save it in a state of react function ==setAdmin(admin);

without admin selected page can't load 
&& typeof admin !== 'undefined'

6) in HTML, should createBallot and addVoter only if admin is selected
 {accounts[0].toLowerCase() === admin.toLowerCase() ? (
        <> 

        </>
        // conditional rendering 
      ) : null}

7)fetch list of ballots in frontend
no function to get all ballots but have variable 
nextBallotId with which we can get all ballots Id use for loop for each Id and getBallot from that 

async function updateBallots() {}
 const [ballots, setBallots] = useState([]);


8) update the useEffect 
(Reusable) create new hook, it changes whenever variable changes
useEffect(() => {
    if(isReady()) {
      updateBallots();
    }
  }, [accounts, contract, web3, admin]);

createBallot
    await updateBallots();

9) Update 
{ballot.choices.map(choice => (

10)make changes for end date of vote 
{(new Date(parseInt(ballot.end) * 1000)).toLocaleString()}

11)Impliment Voting button, it will have select which will show all the choices for vote = which will trigger the vote function of SC add onSubmit button 
<form onSubmit={e => vote(e, ballot.id)}>

12) prepare function vote 
 await updateBallots();

13) when vote expired, we shoulden't see the button to vote 
Once user has voted, Vote button should  hide

14) We have to take care of hasVoted function in order to create isFinished function

15) hasVoted property on ballot (we don't get it from SC)