/*
Write a query to output the start and end dates of projects listed by the number of days 
it took to complete the project in ascending order. If there is more than one project 
that have the same number of completion days, then order by the start date of the project.
*/
SELECT start_date, MIN(end_date)
FROM (
    SELECT start_date 
    FROM projects
    WHERE start_date NOT IN (SELECT end_date FROM projects)) as s
    INNER JOIN (
        SELECT end_date
        FROM projects
        WHERE end_date NOT IN (SELECT start_date FROM projects)) as e
WHERE end_date > start_date
GROUP BY start_date
ORDER BY MIN(end_date) - start_date, start_date;

/*
Write a query to output the names of those students whose best friends got offered a higher 
salary than them. Names must be ordered by the salary amount offered to the best friends. 
It is guaranteed that no two students got same salary offer.
*/
SELECT name
FROM students as s
INNER JOIN friends as f
    ON s.id = f.id
INNER JOIN packages as p
    ON p.id = s.id
INNER JOIN packages as pf
    ON pf.id = f.friend_id
WHERE p.salary < pf.salary
ORDER BY pf.salary;

/*
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X. 
List the rows such that X1 ≤ Y1. 
*/
SELECT f1.x, f1.y
FROM functions as f1
INNER JOIN functions as f2
    ON f1.x = f2.y AND f1.y = f2.x
GROUP BY f1.x, f1.y
HAVING COUNT(f1.x) > 1 OR f1.x < f1.y
ORDER BY f1.x;

/*
Samantha interviews many candidates from different colleges using coding challenges and contests. 
Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, 
total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. 
Exclude the contest from the result if all four sums are 0.
*/
SELECT 
    c.contest_id, 
    c.hacker_id, 
    c.name,
    IFNULL(SUM(total_submissions), 0) as total_submissions,
    IFNULL(SUM(total_accepted_submissions), 0) as total_accepted_submissions,
    IFNULL(SUM(total_views), 0) as total_views,
    IFNULL(SUM(total_unique_views), 0) as total_unique_views
FROM contests as c 
    JOIN colleges USING (contest_id)
    JOIN challenges USING (college_id)
    LEFT JOIN (SELECT challenge_id, SUM(total_views) as total_views, SUM(total_unique_views) as total_unique_views
               FROM view_stats
               GROUP BY challenge_id) as vs 
               USING (challenge_id)
    LEFT JOIN (SELECT challenge_id, SUM(total_submissions) as total_submissions, SUM(total_accepted_submissions) as total_accepted_submissions
               FROM submission_stats
               GROUP BY challenge_id) as ss 
               USING (challenge_id)
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING total_submissions + total_accepted_submissions + total_views + total_unique_views > 0
ORDER BY c.contest_id;

/*
Write a query to print total number of unique hackers who made at least submission each day 
(starting on the first day of the contest), and find the hacker_id and name of the hacker who 
made maximum number of submissions each day. If more than one such hacker has a maximum number 
of submissions, print the lowest hacker_id. The query should print this information for each day 
of the contest, sorted by the date.
*/
SELECT t1.submission_date, t1.unique_submissions, t2.hacker_id, t3.name
FROM (SELECT submission_date, COUNT(DISTINCT hacker_id) as unique_submissions
      FROM submissions as s
      WHERE (SELECT COUNT(DISTINCT submission_date) 
             FROM submissions
             WHERE hacker_id = s.hacker_id AND submission_date < s.submission_date)
            = DATEDIFF(s.submission_date, '2016-03-01')
      GROUP BY submission_date) as t1
    INNER JOIN (SELECT submission_date,
          (SELECT hacker_id FROM submissions
           WHERE submission_date = s.submission_date 
           GROUP BY hacker_id
           ORDER BY COUNT(submission_id) DESC, hacker_id LIMIT 1) as hacker_id
          FROM (SELECT DISTINCT submission_date FROM submissions) as s) as t2
        ON t1.submission_date = t2.submission_date
    INNER JOIN hackers t3
        ON t2.hacker_id = t3.hacker_id
ORDER BY submission_date;
