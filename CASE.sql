USE united_nations;

-- grouping the umemployment rate into categories
SELECT
		Country_name,
		Est_population_in_millions,
		Pct_unemployment,
		Time_period,
	CASE
		WHEN Pct_unemployment ='0' OR Pct_unemployment <='10' THEN 'LOW'
		WHEN Pct_unemployment >'10' AND Pct_unemployment <='20' THEN 'AVERAGE'
		WHEN Pct_unemployment >'20' AND Pct_unemployment  <='30' THEN 'BAD'
		ELSE 'SEVERE'
    END AS Unemployment_group
FROM access_to_basic_services
WHERE Time_period = '2020' AND Pct_unemployment IS NOT NULL
ORDER BY Unemployment_group ;