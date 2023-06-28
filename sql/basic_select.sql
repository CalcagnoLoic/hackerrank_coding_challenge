#Query all columns for all American cities in the CITY table with populations larger 
#than 100000. The CountryCode for America is USA.
SELECT * 
FROM CITY
WHERE CountryCode = "USA" 
    AND Population > 100000;

/*
Query the NAME field for all American cities in the CITY table with 
populations larger than 120000. The CountryCode for America is USA. 
*/
SELECT Name
FROM City
WHERE CountryCode = "USA" 
    AND Population > 120000;

/*
Query all columns (attributes) for every row in the CITY table.
*/
SELECT *
FROM City;

#Query all columns for a city in CITY with the ID 1661.
SELECT *
FROM City
WHERE id = 1661;

/*
Query all attributes of every Japanese city in the CITY table. 
The COUNTRYCODE for Japan is JPN. 
*/
SELECT * 
FROM City 
WHERE CountryCode = "JPN";

/*
Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN. 
*/
SELECT Name
FROM City
WHERE CountryCode = "JPN";

#Query a list of CITY and STATE from the STATION table. 
SELECT City, State
FROM Station;

/*
Query a list of CITY names from STATION for cities that have an even ID number. 
Print the results in any order, but exclude duplicates from the answer. 
*/
SELECT DISTINCT City
FROM Station
WHERE id % 2 = 0;

/*
Find the difference between the total number of CITY entries in the 
table and the number of distinct CITY entries in the table. 
*/