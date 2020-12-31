


#1. The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';
  
#2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.

SELECT id,stadium,team1,team2
  FROM game where id = 1012;

#3. The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored. Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player,teamid,stadium,mdate
  FROM game JOIN goal ON (id=matchid) where teamid = 'GER';
  
#4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

select team1, team2, player 
from game join goal on (game.id = goal.matchid) where player like 'Mario%';

#5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
  FROM goal join eteam on (goal.teamid = eteam.id)
 WHERE gtime<=10;
 
#6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

select mdate, teamname 
from game join eteam on (team1=eteam.id) 
where coach like 'Fernando Santos';

#7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

select player 
from game join goal on (game.id = goal.matchid)
where stadium like 'National Stadium, Warsaw';

#more difficult questions 

#8. Show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE teamid<>'GER' and (team1 = 'GER' OR team2 = 'GER');
    
#9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(player)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname;

#10. Show the stadium and the number of goals scored in each stadium.
select stadium, count(player)
from game join goal on id=matchid
group by stadium;

#11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, count(player)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
group by matchid, mdate


    

