# tournament-results
Welcome to the github page of my implementation of the Udacity project nr 2: Tournament Results. 
In the tournament folder you will find the tournament.py file which contains the functions for the 
tournament results and tournament.sql where the SQL queries are stored. 

##Tournament.py functions
**connect()**
Connects with the database

**deleteMatches()**
Delete the table with all the matches

**detelePlayers**
Delete the table with all the players

**countPlayers()**
Gives the number of players registered

**registerPlayer(name)**
Add a player to the list.

**playerStandings()** 
returns the standings ranked by wins

**reportMatch(winner,loser)**
updates the matches table with a score

**swissPairings()**
Gives the next round matchups based on ranking
