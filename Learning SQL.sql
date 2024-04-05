-- JOIN
USE invoicing;

 SELECT 
 *
 FROM clients;
 
 SELECT
 *
FROM invoices;
 
 SELECT
 *
 FROM payment_methods;
 
 SELECT
 *
 FROM payments;
 
 
 SELECT
	clients.name,
	clients.address,
	clients.phone,
	payments.amount,
	payments.date,
    clients.client_id
 FROM clients
INNER JOIN payments
ON clients.client_id = payments.client_id;

-- a query to get the total amount each customer spent
SELECT
	clients.name,
	SUM(payments.amount) AS sum_of_amount
FROM clients
INNER JOIN payments
ON clients.client_id = payments.client_id
GROUP BY clients.name
ORDER BY sum_of_amount desc;

-- what payment method did our client use to make their payment
SELECT
	clients.name,
	clients.address,
	payment_methods.name as payment_method
FROM clients
INNER JOIN payments
ON  clients.client_id = payments.client_id
INNER JOIN payment_methods
ON payments.payment_method = payment_methods.payment_method_id;

-- 9th March 2024 USING LEFT JOIN
USE invoicing;

 SELECT 
 *
 FROM clients;
 
 SELECT
 *
FROM invoices;
 
 SELECT
 *
 FROM payment_methods;
 
 SELECT
 *
 FROM payments;


-- retrieving the invoice total for each customer using left join
SELECT 
    clients.name,
    SUM(invoices.invoice_total) as total_invoice
FROM clients
LEFT JOIN invoices
ON clients.client_id = invoices.client_id
GROUP BY clients.name;

--  retrieving the payment methods for each customer
SELECT 
	clients.name,
    payment_methods.name AS payment_type
FROM clients
LEFT JOIN payments
ON clients.client_id = payments.client_id
LEFT JOIN payment_methods
ON payments.payment_method = payment_methods.payment_method_id;

-- a query to return sum of payments total for each client sowing their names.
SELECT
	clients.name,
    SUM(invoices.payment_total) as payment_total
FROM clients
LEFT JOIN invoices
ON clients.client_id = invoices.client_id
GROUP BY clients.name;



-- SELF JOIN USING THE SQL HR DATABASE

USE sql_hr;

SELECT 
*
FROM employees;

SELECT
	e1.employee_id,
    concat(e1.first_name, ' ',e1.last_name)as full_name,
	e2.first_name as manager
FROM employees AS e1
LEFT JOIN employees AS e2
ON e1.reports_to = e2.employee_id;

SELECT
	concat(first_name, ' ',last_name)as full_name,
    job_title,
    salary
FROM employees
WHERE salary > (SELECT 
					ROUND(AVG(salary),1) as avg_salary
				from employees)
AND job_title LIKE 'S%';