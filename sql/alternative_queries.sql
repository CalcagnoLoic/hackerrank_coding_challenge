/*
Write a query to print the pattern P(20).
https://www.geeksforgeeks.org/print-different-star-patterns-sql/

* * * * * 
* * * * 
* * * 
* * 
*

*/
SET @count := 21;

SELECT REPEAT("* ", @count := @count - 1)
FROM information_schema.tables;

/*
Write a query to print the pattern P(20).

* 
* * 
* * * 
* * * * 
* * * * *

*/
SET @count := 0;

SELECT REPEAT("* ", @count := @count +1)
FROM information_schema.tables
LIMIT 20;

/*
Write a query to print all prime numbers less than or equal to 1000. 
Print your result on a single line, and use the ampersand (&) 
character as your separator (instead of a space).
*/
SELECT GROUP_CONCAT(numberB SEPARATOR "&")
FROM(
    SELECT @number := @number+1 as numberB
    FROM information_schema.tables as table1, information_schema.tables as table2, (SELECT @number:=1) as table0
) as tablenum
WHERE numberB <= 1000 AND NOT EXISTS (
    SELECT * FROM(
        SELECT @num := @num+1 as numberA
        FROM information_schema.tables as table1, information_schema.tables as table2, (SELECT @num:=1) as table1
        LIMIT 1000
    ) as tablenum1
    WHERE FLOOR(numberB/numberA) = numberB/numberA AND numberA < numberB AND numberA > 1
);
