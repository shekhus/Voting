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

6) in HTML shoe createBallot and addVoter only if admin is selected
 {accounts[0].toLowerCase() === admin.toLowerCase() ? (
        <> 

        </>
      ) : null}

7)fetch list of ballots in frontend
no function to get all ballots but have variable 
nextBallotId with which we can get all ballots Id use for loop for each Id and getBallot from that 

async function updateBallots() {}
update the useEffect

8) (Reusable) create new hook, it changes whenever variable changes

9)make changes for end date of vote 
{(new Date(parseInt(ballot.end) * 1000)).toLocaleString()}

10)Impliment Voting button, it will have select which will show all the choices for vote = which will trigger the vote function of SC add onSubmit button 

11) prepare function vote 

12) when vote expired, we shoulden't see the button to vote 
Once user has voted, Vote button should  hide

13) We have to take care of hasVoted function in order to create isFinished function

14) hasVoted property on ballot (we don't get it from SC)