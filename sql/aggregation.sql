/*
Query a count of the number of cities in CITY having a Population larger than 100.000. 
*/
SELECT COUNT(Name)
FROM City
WHERE Population > 100000;

/*
Query the total population of all cities in CITY where District is California. 
*/
SELECT SUM(Population)
FROM City
WHERE District = "California";

/*
Query the average population of all cities in CITY where District is California.
*/
SELECT AVG(Population)
FROM City
WHERE District = "California";

/*
Query the average population for all cities in CITY, rounded down to the nearest integer.
*/
SELECT FLOOR(AVG(Population))
FROM City;

/*
Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
*/
SELECT SUM(Population)
FROM City
WHERE Countrycode = "JPN";

/*
Query the difference between the maximum and minimum populations in CITY.
*/
SELECT MAX(Population) - MIN(Population)
FROM City;

/*
Samantha was tasked with calculating the average monthly salaries for all employees in the 
EMPLOYEES table, but did not realize her keyboard's 0 key was broken until after completing 
the calculation. She wants your help finding the difference between her miscalculation 
(using salaries with any zeros removed), and the actual average salary.

Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries),
and round it up to the next integer.
*/
SELECT CEIL(AVG(salary) - AVG(REPLACE(CAST(salary AS CHAR), "0", "")))
FROM Employees

/*
We define an employee's total earnings to be their monthly (salary x months) worked, and the maximum total 
earnings to be the maximum total earnings for any employee in the Employee table. Write a 
query to find the maximum total earnings for all employees as well as the total number of 
employees who have maximum total earnings. Then print these values as 2 space-separated integers.
*/
SELECT (months*salary) AS max_earnings, COUNT(*)
FROM Employee
GROUP BY max_earnings
HAVING max(max_earnings)
ORDER BY max_earnings DESC
LIMIT 1;

/*
Query the following two values from the STATION table:
--The sum of all values in LAT_N rounded to a scale of 2 decimal places.
--The sum of all values in LONG_W rounded to a scale of 2 decimal places.
*/
SELECT ROUND(SUM(LAT_N), 2) AS lat, ROUND(SUM(LONG_W), 2) AS lon
FROM Station;

/*
Query the sum of Northern Latitudes (LAT_N) from STATION having values greater 
than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal places.
*/
SELECT TRUNCATE(SUM(LAT_N), 4)
FROM Station
WHERE LAT_N > 38.7880 AND LAT_N < 137.2345;

/*
Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. 
Truncate your answer to 4 decimal places.
*/
SELECT TRUNCATE(MAX(LAT_N),4)
FROM Station
WHERE LAT_N < 137.2345;

/*
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION 
that is less than 137.2345. Round your answer to 4 decimal places.
*/
SELECT ROUND(LONG_W, 4)
FROM Station
WHERE LAT_N = (
    SELECT MAX(LAT_N)
    FROM Station
    WHERE LAT_N < 137.2345;
)

/*
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7880. 
Round your answer to 4 decimal places.
*/
SELECT ROUND(MIN(LAT_N), 4)
FROM Station
WHERE LAT_N > 38.7780;

/*
Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION 
is greater than 38.7880. Round your answer to 4 decimal places.
*/
SELECT ROUND(LONG_W, 4)
FROM Station
WHERE LAT_N = (
    SELECT MIN(LAT_N)
    FROM Station
    WHERE LAT_N > 38.7780
);

/*
Consider P1(a, c) and P2(b, d) to be two points on a 2D plane.
    a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
    b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
    c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
    d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places.
*/
SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)), 4)
FROM Station;

/*
Consider P1(a, c) and P2(b, d) to be two points on a 2D plane where (a, b) are the respective 
minimum and maximum values of Northern Latitude (LAT_N) and (c, d) are the respective minimum 
and maximum values of Western Longitude (LONG_W) in STATION.
Query the Euclidean Distance between points P1 and P2 and format your answer to display 4 decimal digits.
*/
SELECT ROUND(SQRT(POW(MAX(LAT_N)-MIN(LAT_N), 2) + POW(MAX(LONG_W)-MIN(LONG_W), 2)), 4)
FROM Station;

/*
A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places. 
*/
SELECT ROUND(x.LAT_N,4) from STATION x, STATION y
GROUP BY x.LAT_N
HAVING SUM(SIGN(1-SIGN(y.LAT_N-x.LAT_N))) = (COUNT(*)+1)/2;