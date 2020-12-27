#SQL ZOO TUTORIAL - SELECT IN SELECT 

#List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');
      
#Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name from world
	where continent = 'Europe' AND gdp/population > 
	(select gdp/population from world 
	where name = 'United Kingdom');
    
#List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
select name, continent from world 
where continent in ('South America','Oceania')
order by name ASC;

#Which country has a population that is more than Canada but less than Poland? Show the name and the population.
select name, population 
from world 
where population > 
(select population from world where name = 'Canada')
and population <
(select population from world where name = 'Poland');

#Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
#Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT 
  name, 
  CONCAT(ROUND((population*100)/
(SELECT population 
FROM world WHERE name='Germany'), 0), '%')
FROM world
WHERE population IN (SELECT population
                     FROM world
                     WHERE continent='Europe');

#Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
select name 
from world 
where gdp > (select max(gdp) from world where continent = 'Europe');

/*Find the largest country (by area) in each continent, show the continent, the name and the area:*/
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0);
          
#List each continent and the name of the country that comes first alphabetically.
SELECT continent, MIN(name) AS name
FROM world 
GROUP BY continent
ORDER by continent;

#9 Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
select name, continent, population 
from world
where continent in (
   select continent from world
   group by continent 
   having max(population) <= 25000000
);

#10 Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
select name,continent from world x
where x.population >=all(select y.population*3 from world y 
where y.continent=x.continent and population >0 and x.name!=y.name )