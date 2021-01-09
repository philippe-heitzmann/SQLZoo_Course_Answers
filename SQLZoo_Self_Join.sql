#SQLZoo Self Join

#1. How many stops are in the database.

select count(id)
from stops ;

#2. Find the id value for the stop 'Craiglockhart'

select id 
from stops 
where name = 'Craiglockhart';

#3. Give the id and the name for the stops on the '4' 'LRT' service.

SELECT id, name
FROM stops
JOIN route ON stops.id = route.stop
WHERE num = 4 and company = 'LRT';

#4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
having COUNT(*) = 2; 

#5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop = 149;

#6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name='London Road';

#7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

SELECT distinct a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' and stopb.name='Leith';

#8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

select a.company, a.num
from route a join route b on (a.num = b.num and a.company = b.company)
join stops stopa on (a.stop = stopa.id)
join stops stopb on (b.stop = stopb.id)
where stopa.name = 'Craiglockhart' and stopb.name = 'Tollcross'; 

#9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.

select distinct stopb.name, b.company, b.num
from route a join route b on (a.num = b.num and a.company = b.company)
join stops stopa on (a.stop = stopa.id)
join stops stopb on (b.stop = stopb.id)
where stopa.name = 'Craiglockhart';


#10. Find the routes involving two buses that can go from Craiglockhart to Lochend. 


SELECT DISTINCT a.num, a.company, stopb.name,  c.num,  c.company
FROM route a JOIN route b
ON (a.company = b.company AND a.num = b.num)
JOIN ( route c JOIN route d ON (c.company = d.company AND c.num= d.num))
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
JOIN stops stopc ON (c.stop = stopc.id)
JOIN stops stopd ON (d.stop = stopd.id)
WHERE  stopa.name = 'Craiglockhart' AND stopd.name = 'Lochend'
            AND  stopb.name = stopc.name
ORDER BY LENGTH(a.num), b.num, stopb.id, LENGTH(c.num), d.num;