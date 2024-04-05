-- a query to use the database awesome chocolates
USE `awesome chocolates`;

-- a query to return all the columns in the table geo
SELECT
*
FROM geo;

-- a query to return all the columns in the table people
SELECT
*
FROM people;


-- a query to return all the columns in the table products
SELECT
*
FROM products;

-- a query to return all the columns in the table sales
SELECT
*
FROM sales;


-- a query to print the sales where amounts are >2000 and boxes are <100
SELECT
	*
FROM sales
WHERE Amount > 2000 AND Boxes < 100
ORDER BY Amount DESC;

-- how many sales each of the sales persons had in january 2022
SELECT
	 people.Salesperson,
	count(*) AS shipment_count
FROM sales
JOIN people
ON sales.SPID = people.SPID
WHERE month(sales.SaleDate) = 01 and year(sales.SaleDate) = 2022
GROUP BY people.Salesperson;

-- how many sales each of the sales persons had in january 2022
SELECT
	 people.Salesperson,
	count(*) AS total_sales
FROM sales
JOIN people
ON sales.SPID = people.SPID
WHERE EXTRACT(YEAR FROM sales.SaleDate) = 2022
AND EXTRACT(MONTH FROM sales.SaleDate) = 1
GROUP BY people.Salesperson;

-- which product sells more boxes? mik bars or eclairs
SELECT
    products.Product,
    sum(sales.boxes) as total_boxes
FROM products
INNER JOIN sales
ON products.PID = sales.PID
WHERE products.Product IN ('Milk Bars','Eclairs')
GROUP BY  products.Product;

-- which product sells more boxes in the first 7 days of february 2022? mikl bars or eclairs?
SELECT
    products.Product,
    sum(sales.boxes) as total_boxes
FROM products
INNER JOIN sales
ON products.PID = sales.PID
WHERE products.Product IN ('Milk Bars','Eclairs')
and (sales.SaleDate BETWEEN '2022-02-01' AND '2022-02-07')
GROUP BY  products.Product;

         
-- Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday? CORRECT
SELECT
*,
CASE WHEN weekday(saledate)=2 then 'wednesday shipment' ELSE ' '
END as 'W shipment'
FROM sales
WHERE customers <100 and boxes <100;

-- What are the names of salespersons who had at least one sales in the first 7 days of january 2022
SELECT
	DISTINCT people.salesperson
FROM sales
JOIN people
ON sales.spid = people.spid 
WHERE (sales.Saledate BETWEEN '2022-01-01' 
	AND '2022-01-07');



    
-- which salesperson did not make any shipment in the first 7 days of january 2022
SELECT
	people.salesperson
FROM people
WHERE people.spid not in (SELECT 
							DISTINCT sales.spid 
								FROM sales
									WHERE sales.Saledate BETWEEN '2022-01-01'	
										AND '2022-01-07');


-- How many times we shipped more than 1000 boxes in each month
SELECT 
	YEAR(saledate) 'year',
    MONTH(saledate) 'month',
    Count(*) 'time we shipped 1k boxes'
FROM sales
WHERE boxes >1000
GROUP BY YEAR(saledate), Month(saledate)
ORDER BY YEAR(saledate), MONTH(saledate);

-- Did we ship at least one box of 'AFTER NINES' to 'NEW ZEALAND' on all months
set @product_name = 'After nines';
set @country_name = 'New zealand';

SELECT
	YEAR(saledate) 'year',
    MONTH(saledate) 'month',
IF (SUM(boxes)>1,'yes','no') 'status'
FROM sales
JOIN products 
ON products.pid = sales.pid
JOIN geo
ON geo.geoid = sales.geoid
WHERE products.product = @product_name 
	and geo.geo = @country_name
GROUP BY YEAR(saledate), MONTH(saledate)
ORDER BY YEAR(saledate), MONTH(saledate);


-- INDIA OR AUSTRALIA? Who buys more chocolate boxes on a monthly basis
SELECT 
	YEAR(saledate) 'year',
    MONTH(saledate) 'month',
SUM(CASE 	
		WHEN geo.geo = 'india' = 1 THEN boxes 	
			ELSE 0
				END) 'India boxes',
SUM(CASE 	
		WHEN geo.geo = 'Australia' = 1 THEN boxes 	
			ELSE 0
				END) 'Australia boxes'
FROM sales
JOIN Geo 
ON Geo.geoid = sales.geoid
GROUP BY YEAR(saledate), MONTH(saledate)
ORDER BY YEAR(saledate), MONTH(saledate);
    
    
    

 