/*
Given the CITY and COUNTRY tables, query the sum of the populations 
of all cities where the CONTINENT is 'Asia'.
*/
SELECT SUM(city.population)
FROM city
LEFT JOIN country
    ON city.countrycode = country.code
WHERE country.continent = "Asia";

/*
Given the CITY and COUNTRY tables, query the names of all cities where 
the CONTINENT is 'Africa'. 
*/
SELECT city.name
FROM city
LEFT JOIN country
    ON city.countrycode = country.code
WHERE country.continent = "Africa";

/*
Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent)
and their respective average city populations (CITY.Population) rounded down to the nearest integer.
*/
SELECT country.continent AS continents, FLOOR(AVG(city.population)) AS populations
FROM city
INNER JOIN country
    ON city.countrycode = country.code
GROUP BY country.continent
ORDER BY country.continent;

/*
Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report 
must be in descending order by grade -- i.e. higher grades are entered first. If there is more 
than one student with the same grade (8-10) assigned to them, order those particular students 
by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and 
list them by their grades in descending order. If there is more than one student with the same 
grade (1-7) assigned to them, order those particular students by their marks in ascending order.
*/
SELECT
    CASE WHEN s.marks >= 70 THEN s.name ELSE Null END as name,
    g.grade, 
    s.marks
FROM students AS s
INNER JOIN grades AS g
    ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC, name ASC, s.marks ASC;

/*
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! 
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more 
than one challenge. Order your output in descending order by the total number of challenges in which 
the hacker earned a full score. If more than one hacker received full scores in same number of challenges, 
then sort them by ascending hacker_id.
*/
SELECT h.hacker_id, h.name
FROM hackers as h
    INNER JOIN submissions as s
        ON h.hacker_id = s.hacker_id
    INNER JOIN challenges as c
        ON s.challenge_id = c.challenge_id
    INNER JOIN difficulty as d
        ON c.difficulty_level = d.difficulty_level 
WHERE d.score = s.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(c.challenge_id) > 1
ORDER BY COUNT(c.challenge_id) DESC, h.hacker_id 

/*
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number of gold galleons needed 
to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, 
and power of the wands that Ron's interested in, sorted in order of descending power. If more than 
one wand has same power, sort the result in order of descending age.
*/
SELECT (
    SELECT w1.id
    FROM wands as w1
        INNER JOIN wands_property as wp1
            ON w1.code = wp1.code
    WHERE wp1.age = wp.age AND w1.coins_needed = MIN(w.coins_needed)
), wp.age, min(w.coins_needed), w.power
FROM wands as w
    INNER JOIN wands_property as wp
        ON w.code = wp.code
WHERE wp.is_evil = 0 
GROUP BY w.power DESC, wp.age DESC;

/*
Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and 
the total number of challenges created by each student. Sort your results by the total number of 
challenges in descending order. If more than one student created the same number of challenges, 
then sort the result by hacker_id. If more than one student created the same number of challenges 
and the count is less than the maximum number of challenges created, then exclude those students from the result.
*/
SELECT h.hacker_id, h.name, COUNT(c.challenge_id) as c_count
FROM hackers as h
    INNER JOIN challenges as c
        ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id, h.name
HAVING c_count = (
    SELECT COUNT(c1.challenge_id) as c_sort
    FROM challenges as c1
    GROUP BY c1.hacker_id
    ORDER BY c_sort DESC LIMIT 1
) 
OR c_count IN (
    SELECT DISTINCT c_count2 as c_unique
    FROM (
        SELECT h2.hacker_id, h2.name, COUNT(c2.challenge_id) as c_count2
        FROM hackers as h2
            INNER JOIN challenges as c2
                ON h2.hacker_id = c2.hacker_id
        GROUP BY h2.hacker_id, h2.name) as counts
    GROUP BY c_unique
    HAVING COUNT(c_unique) = 1
)
ORDER BY c_count DESC, h.hacker_id;

/*
You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!

The total score of a hacker is the sum of their maximum scores for all of the challenges. 
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending 
score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
Exclude all hackers with a total score of 0 from your result.
*/
SELECT h.hacker_id, h.name, SUM(scores.max_score)
FROM (
    SELECT s1.hacker_id, s1.challenge_id, max(s1.score) as max_score
    FROM submissions as s1
    GROUP BY s1.hacker_id, s1.challenge_id
) as scores
INNER JOIN hackers as h
    ON h.hacker_id = scores.hacker_id
GROUP BY h.hacker_id, h.name    
HAVING SUM(scores.max_score) > 0
ORDER BY SUM(scores.max_score) DESC, h.hacker_id ASC;

