-- Loading Data Into A Database

CREATE TABLE geo_lookup (
    country VARCHAR(30) PRIMARY KEY,
    region VARCHAR(30));

COPY geo_lookup (
    country,
    region)
FROM 'D:\Documents\Projects\Elist\geo_lookup.csv' 
DELIMITER ',' 
CSV HEADER
ENCODING 'UTF8';

CREATE TABLE customers (
    customer_id VARCHAR(30) PRIMARY KEY,
    marketing_channel VARCHAR(30),
	account_creation_method VARCHAR(30),
    country_code VARCHAR(30),
    loyalty_program INTEGER,
    created_on DATE,
	FOREIGN KEY (country_code) REFERENCES geo_lookup(country) ON DELETE CASCADE
);

COPY customers (
    customer_id,
    marketing_channel,
	account_creation_method,
    country_code,
    loyalty_program,
    created_on)
FROM 'D:\Documents\Projects\Elist\customers.csv' 
DELIMITER ',' 
CSV HEADER
ENCODING 'UTF8';

CREATE TABLE orders (
    order_id VARCHAR(30) PRIMARY KEY,
    customer_id VARCHAR(30),
    purchase_date DATE,
    product_id VARCHAR(30),
    product_name VARCHAR(30),
	order_total NUMERIC(10,2),
    purchase_platform VARCHAR(10),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);					

COPY orders (
    order_id,
    customer_id,
    purchase_date,
    product_id,
    product_name,
	order_total,
    purchase_platform)
FROM 'D:\Documents\Projects\Elist\orders.csv' 
DELIMITER ',' 
CSV HEADER
ENCODING 'UTF8';

CREATE TABLE orders_refunded (
    order_id VARCHAR(30),
    purchase_date DATE,
    ship_date DATE,
	delivery_date DATE,
	refund_date DATE,
	FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);	

COPY orders_refunded (
   order_id,
    purchase_date,
    ship_date,
	delivery_date,
	refund_date)
FROM 'D:\Documents\Projects\Elist\orders_refunded.csv' 
DELIMITER ',' 
CSV HEADER
ENCODING 'UTF8';		

-- Combining and Oranizing Data For Analysis

-- Addding product table

CREATE TABLE product (
	product_id VARCHAR(30) PRIMARY KEY,
	product_name VARCHAR(30),
	category VARCHAR(30),
	brand VARCHAR(30))

	WITH product_cte AS (select distinct product_id, product_name
							from orders
							order by product_name)

INSERT INTO product (product_id, product_name)
SELECT * FROM product_cte

-- Fixing the product_id table since the same product had multiple IDs

Update product 
SET product_name = 
	Case WHEN product_name ILIKE '%gaming monitor%' THEN '27in 4K Gaming Monitor'
		 WHEN product_name ILIKE '%soundsport%' THEN 'Bose Soundsport Headphones'
		 ELSE product_name end
		 
DELETE FROM product
WHERE product_id NOT IN (
    SELECT MIN(product_id)
    FROM product
    GROUP BY product_name
);

UPDATE product  
SET category =  
    CASE  
        WHEN product_name LIKE '%Monitor%' THEN 'Monitor'  
        WHEN product_name LIKE '%Headphones%' THEN 'Headphones'  
        WHEN product_name LIKE '%Laptop%' OR product_name LIKE '%Macbook%' THEN 'Computers'  
        WHEN product_name LIKE '%Cable%' OR product_name LIKE '%Webcam%' THEN 'Accessories'  
        ELSE 'Phones'  
    END;
	
UPDATE product  
SET brand =  
    CASE  
        WHEN product_name LIKE '%Samsung%' THEN 'Samsung'  
        WHEN product_name LIKE '%Lenovo%' THEN 'Lenovo'  
        WHEN product_name LIKE '%Bose%' THEN 'Bose'  
        WHEN product_name LIKE '%Apple%' OR product_name LIKE '%Mac%' THEN 'Apple'  
        ELSE 'Other'  
    END;

-- Fixing the product_id column in the orders table

UPDATE orders 
SET product_name = 
	Case WHEN product_name ILIKE '%gaming monitor%' THEN '27in 4K Gaming Monitor'
		 WHEN product_name ILIKE '%soundsport%' THEN 'Bose Soundsport Headphones'
		 ELSE product_name end

UPDATE orders AS o
SET product_id = p.product_id
FROM product AS p
WHERE o.product_name = p.product_name;

ALTER TABLE orders  
DROP COLUMN product_name;

ALTER TABLE orders  
ADD CONSTRAINT fk_orders_product  
FOREIGN KEY (product_id)  
REFERENCES product(product_id)  
ON DELETE CASCADE;

