/*
Write a query identifying the type of each record in the TRIANGLES table using 
its three side lengths. Output one of the following statements for each record in the table:
    Equilateral: It's a triangle with 3 sides of equal length.
    Isosceles: It's a triangle with 3 sides of equal length.
    Scalene: It's a triangle with 3 sides of differing lengths.
    Not A Triangle: The given values of A, B, and C don't form a triangle.
*/
SELECT 
    CASE 
        WHEN A = B AND B = C THEN "Equilateral"
        WHEN A + B <= C THEN "Not A Triangle"
        WHEN B + C <= A THEN "Not A Triangle"
        WHEN A + C <= B THEN "Not A Triangle"
        WHEN A = B AND A <> C THEN "Isosceles"
        WHEN A = C AND A <> B THEN "Isosceles"
        WHEN B = C AND A <> B THEN "Isosceles"
        ELSE "Scalene"
    END
FROM Triangles;

/*
Generate the following two result sets:

    1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately 
    followed by the first letter of each profession as a parenthetical 
    (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), 
    AProfessorName(P), and ASingerName(S).

    2. Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the 
    occurrences in ascending order, and output them in the following format:
            There are a total of [occupation_count] [occupation]s.
    where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS 
    and [occupation] is the lowercase occupation name. If more than one Occupation has the 
    same [occupation_count], they should be ordered alphabetically.
*/
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')')
FROM Occupations
ORDER BY Name;

SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(Occupation), 's.')
FROM Occupations
GROUP BY Occupation
ORDER BY COUNT(Occupation) ASC, Occupation;

/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted 
alphabetically and displayed underneath its corresponding Occupation. 
The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
*/
WITH temporary_table AS(
    SELECT *, ROW_NUMBER()
        OVER(PARTITION BY Occupation ORDER BY Name) as Row_num
    FROM Occupations
)

SELECT 
    MAX(CASE WHEN Occupation = "Doctor" THEN Name END) as doctor,
    MAX(CASE WHEN Occupation = "Professor" THEN Name END) as professor,
    MAX(CASE WHEN Occupation = "Singer" THEN Name END) as singer,
    MAX(CASE WHEN Occupation = "Actor" THEN Name END) as actor
FROM temporary_table
GROUP BY Row_num;

/*
You are given a table, BST, containing two columns: N and P, where N represents the 
value of a node in Binary Tree, and P is the parent of N.

Write a query to find the node type of Binary Tree ordered by the value of the node. 
Output one of the following for each node:
    Root: If node is root node.
    Leaf: If node is leaf node.
    Inner: If node is neither root nor leaf node.
*/
SELECT N, 
    CASE
        WHEN P IS NULL THEN "Root"
        WHEN (SELECT COUNT(*) FROM BST AS child WHERE child.P = father.N) > 0 THEN "Inner"
        ELSE "Leaf"
    END
FROM BST AS father
ORDER BY N;

/*
Write a query to print the company_code, founder name, total number of 
lead managers, total number of senior managers, total number of managers, 
and total number of employees. Order your output by ascending company_code.
*/
SELECT 
    c.company_code,
    GROUP_CONCAT(DISTINCT c.founder),
    COUNT(DISTINCT lm.lead_manager_code),
    COUNT(DISTINCT sm.senior_manager_code),
    COUNT(DISTINCT m.manager_code),
    COUNT(DISTINCT e.employee_code)
FROM Company AS c
    LEFT JOIN lead_manager AS lm
        ON c.company_code = lm.company_code
    LEFT JOIN senior_manager AS sm
        ON lm.lead_manager_code = sm.lead_manager_code
    LEFT JOIN manager AS m
        ON sm.senior_manager_code = m.senior_manager_code
    LEFT JOIN employee AS e
        ON m.manager_code = e.manager_code
GROUP BY c.company_code
ORDER BY c.company_code