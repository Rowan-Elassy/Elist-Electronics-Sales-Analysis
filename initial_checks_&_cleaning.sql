--Running initial checks and cleaning the data for analysis

-- ORDERS TABLE

-- Checking of duplicates

SELECT order_id, COUNT(*) 
FROM orders
GROUP BY order_id
HAVING 1 > 1

-- checking for and fixing nulls

SELECT * 
FROM orders
WHERE order_id IS NULL
 OR customer_id IS NULL
 OR purchase_date IS NULL
 OR product_id IS NULL
 OR order_total IS NULL
 OR purchase_platform IS NULL

UPDATE orders
SET order_total = COALESCE(order_total, (SELECT avg(order_total) FROM orders))

UPDATE orders
SET purchase_platform = INITCAP(purchase_platform)

-- ORDERS_REFUNDED TABEL

-- Checking of duplicates

SELECT order_id, COUNT(*) 
FROM orders_refunded
GROUP BY order_id
HAVING 1 > 1

-- checking for nulls

SELECT *
FROM orders_refunded
WHERE order_id IS NULL
	OR purchase_date IS NULL
	OR ship_date IS NULL
	OR delivery_date IS NULL
	OR refund_date IS NULL

-- Checking date range

SELECT
    MIN(purchase_date) AS earliest_order_date,
    MAX(purchase_date) AS latest_order_date,
    MIN(ship_date) AS earliest_ship_date,
    MAX(ship_date) AS latest_ship_date,
    MIN(delivery_date) AS earliest_delivery_date,
    MAX(delivery_date) AS latest_delivery_date,
    MIN(refund_date) AS earliest_return_date,
    MAX(refund_date) AS latest_return_date
FROM orders_refunded

-- CUSTOMERS TABLE

-- Checking of duplicates

SELECT customer_id, COUNT(*) 
FROM customers
GROUP BY customer_id
HAVING 1 > 1

-- Checking for and fixing nulls

SELECT *
FROM customers
WHERE customer_id IS NULL
	OR marketing_channel IS NULL
	OR account_creation_method IS NULL
	OR country_code IS NULL
	OR loyalty_program IS NULL
	OR created_on IS NULL
	
INSERT INTO geo_lookup (country) VALUES ('Unknown');

UPDATE customers 
SET marketing_channel = COALESCE(marketing_channel, 'unknown'),
 account_creation_method = COALESCE(account_creation_method, 'unknown'),
 country_code = COALESCE(country_code, 'Unknown')

-- Inspecting and fixing categories

SELECT DISTINCT marketing_channel FROM customers
SELECT DISTINCT account_creation_method FROM customers
SELECT DISTINCT country_code FROM customers
SELECT DISTINCT loyalty_program FROM customers

UPDATE customers 
SET marketing_channel = INITCAP(marketing_channel),
 account_creation_method = INITCAP(account_creation_method)

-- Checking date range

SELECT  
MIN(created_on) AS earliest_created_on,
MAX(created_on) AS latest_created_on
FROM customers

-- GEO_LOOPUP TABLE

-- Checking for duplicates

SELECT country, COUNT(*) 
FROM geo_lookup
GROUP BY country
HAVING 1 > 1

-- Checking for and fixing nulls

SELECT *
FROM geo_lookup
WHERE country IS NULL
	OR region IS NULL

UPDATE geo_lookup 
SET region = 
	CASE WHEN country = 'EU' then 'EMEA'
		WHEN country = 'Unknown' then 'Unknown'
		ELSE region END
