#1. List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962;
 
 #2. Give year of 'Citizen Kane'.

SELECT yr
 FROM movie
 WHERE title='Citizen Kane';
 
 #3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

select id, title, yr 
from movie
where title like '%Star Trek%'
order by yr ASC;

#4. What id number does the actor 'Glenn Close' have?

select id 
from actor 
where name = 'Glenn Close';

#5. What is the id of the film 'Casablanca'

select id 
from movie 
where title  = 'Casablanca';

#6. Obtain the cast list for 'Casablanca'.

select name  
from casting join actor on casting.actorid = actor.id 
where movieid = 11768;

#7. Obtain the cast list for the film 'Alien'

SELECT actor.name
FROM ((actor
JOIN casting
ON casting.actorid = actor.id)
JOIN movie
ON movie.id = casting.movieid)
WHERE movie.title = 'Alien';

#8. List the films in which 'Harrison Ford' has appeared

select movie.title
from casting join movie on movie.id = casting.movieid
join actor on casting.actorid = actor.id
where actor.name = 'Harrison Ford';

#9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

select DISTINCT title 
from casting join movie on movie.id = casting.movieid
join actor on casting.actorid = actor.id
where actor.name = 'Harrison Ford' AND casting.ord != 1;

#10. List the films together with the leading star for all 1962 films.

select title, actor.name
from casting join movie on movie.id = casting.movieid
join actor on casting.actorid = actor.id
where casting.ord = 1 AND movie.yr = 1962;

#11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;








 
 