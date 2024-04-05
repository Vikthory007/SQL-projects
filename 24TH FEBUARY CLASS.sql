-- Selecting the database united nation
USE united_nations;
-- Retrieving all the data in the table access to basic service
SELECT
	*
FROM access_to_basic_services;

-- we are retrieving all the data in the table acess_to_basic_sevices
SELECT 
*
FROM access_to_basic_services
-- using where clause to filter out some records in the table
where Region <> 'oceania' and Region = 'Central and Southern Asia';
-- Query to retrieve the following columns
select
Region,
Sub_region,
Country_name,
Time_period,
Pct_unemployment
from access_to_basic_services
-- Query to filter out time perios between 2017-2019
where (Time_period between '2017' and '2019') and (Pct_unemployment > '3.00');

-- Retreiving the data in the first six columns
select
Region,
Sub_region,
Country_name,
Time_period,
Pct_managed_drinking_water_services,
Pct_managed_sanitation_services

from 
access_to_basic_services
-- FILTERING TIME PERIOD BASED ON THE CONDITION (BETWEEN 2015 -2018)
WHERE (Time_period Between '2015' AND '2018');

-- RETRIEVING THE DATA IN THE SELECTED COLUMNS 
 SELECT
	Region,
	Sub_region,
	Time_period,
	Pct_managed_drinking_water_services,
	Pct_managed_sanitation_services,
	Est_population_in_millions,
	Est_gdp_in_billions
FROM
	access_to_basic_services
    -- USING A WHERE CLAUSE TO FILTER TIME PERIODS AND OTHER CONDITIONS
WHERE
	(Time_period >='2015' AND Time_period <='2018') AND
	(Pct_managed_drinking_water_services > '50') AND (Pct_managed_sanitation_services >'50') AND
	(Region <> 'Oceania');

-- A QUERY TO SELECT THE FIVE COLUMNS LISTED BELOW
select
	Region,
	Sub_region,
	Time_period,
	Est_population_in_millions,
	Est_gdp_in_billions
FROM 
	access_to_basic_services
-- A QUERY TO CHECK FOR NULL AND IS NOT NULL VALUES IN COLUMNS EST POPULATION IN MILLIONS AND EST DGP IN BILLIONS
WHERE (Est_population_in_millions IS NOT NULL) AND (Est_gdp_in_billions IS NOT NULL);

-- a qiery to retrieve all the cloumns in the table access to basic services
SELECT 
*
FROM
	access_to_basic_services
-- a query to return all sub regions ending with asia and limiting to 15 rows
WHERE
	(Sub_region LIKE '%Asia')
LIMIT 15;

-- a query to retrieve the selected colunms in table access to basic services and average the estimated population in millions
select 
	Country_name,
	avg(Est_population_in_millions) As 'avg_pop'
from
	access_to_basic_services
-- grouping by the country name, filtering the avg_pop > 100, sorting in descending order
group by Country_name
having avg_pop > '100'
order by avg_pop desc;

-- A QUERY TO RETURN EST POPULATION FOR EACH COUNTRY IN THE YEAR 2020 REMOVING THE NULL VALUES AND LIMITING TO THE TOP 1O 
SELECT 
	Country_name,
	Est_population_in_millions
FROM access_to_basic_services
where Time_period in (2020) and (Est_population_in_millions is not null)
order by Est_population_in_millions desc
limit 10;

-- a query to retrive selected columns in the table access to basic services, rouding the average of est gdp to 2 decimal places
SELECT
	Country_name,
	Time_period,
	ROUND(AVG(Est_gdp_in_billions),2) AS AVG_GDP
FROM
	access_to_basic_services
-- grouping by the country name and time period and filtering the null values
GROUP BY Country_name,Time_period
HAVING AVG_GDP IS NOT NULL;

-- a query to retrieve selected columns, rounding the average est gdp to 2 decimal places
SELECT
	Country_name,
	ROUND(AVG(Est_gdp_in_billions),2) AS AVG_GDP
FROM
	access_to_basic_services
-- grouping by the country name, filtering to view only the null values
GROUP BY Country_name
HAVING AVG_GDP IS NULL;


