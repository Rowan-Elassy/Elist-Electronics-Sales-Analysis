-- The refund rate and refund count for each product per year

SELECT
  EXTRACT(YEAR FROM o.purchase_date) AS purchase_year,
  p.product_name,
  SUM(CASE WHEN r.order_id IS NOT NULL THEN 1 ELSE 0 END) AS refund_count,
  ROUND(
    SUM(CASE WHEN r.order_id IS NOT NULL THEN 1 ELSE 0 END) * 1.0 / COUNT(o.order_id), 2
  ) AS refund_rate
FROM orders AS o
LEFT JOIN orders_refunded AS r ON o.order_id = r.order_id
LEFT JOIN product AS p ON o.product_id = p.product_id
GROUP BY 1, 2
ORDER BY 1 ASC, 4 DESC;



-- The most popular product within each region

WITH sales_by_product_by_region AS (
  SELECT
    g.region,
    p.product_name,
    COUNT(o.order_id) AS order_count
  FROM orders AS o
  LEFT JOIN product AS p 
  	ON o.product_id = p.product_id
  LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
  LEFT JOIN geo_lookup AS g
    ON c.country_code = g.country
  GROUP BY 1,2
)

SELECT 
  *, RANK() OVER(PARTITION BY region ORDER BY order_count DESC) AS rank
FROM sales_by_product_by_region
ORDER BY rank, region
;



-- The mean and median order value for each region

WITH ordered_orders AS (
    SELECT 
        g.region,
        o.order_total,
        ROW_NUMBER() OVER (PARTITION BY g.region ORDER BY o.order_total ASC) AS row_num,
        COUNT(*) OVER (PARTITION BY g.region) AS total_orders
    FROM orders AS o
    LEFT JOIN customers AS c ON o.customer_id = c.customer_id
    LEFT JOIN geo_lookup AS g ON c.country_code = g.country
    WHERE o.order_total IS NOT NULL AND o.order_total != 0
),

median_calculation AS (
    SELECT 
        region,
        order_total AS median_order_value
    FROM ordered_orders
    WHERE row_num = (total_orders + 1) / 2 
       OR row_num = (total_orders / 2) + 1 
)

SELECT 
    o.region,
    ROUND(AVG(o.order_total), 2) AS mean_order_value,
    ROUND(AVG(m.median_order_value), 2) AS median_order_value 
FROM ordered_orders AS o
LEFT JOIN median_calculation AS m ON o.region = m.region
GROUP BY o.region
ORDER BY mean_order_value DESC;



-- Average quarterly order count and total sales for each region

WITH quarterly_metrics AS (
  SELECT
  g.region,
  DATE_TRUNC('quarter',o.purchase_date) AS quarter,
  COUNT(o.order_id) AS order_count,
  ROUND(SUM(o.order_total),2) AS sales_volume,
  ROUND(AVG(o.order_total),2) AS AOV
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
LEFT JOIN geo_lookup AS g
ON c.country_code = g.country
GROUP BY 1, 2
ORDER BY 1
)

SELECT
  region,
  ROUND(AVG(order_count),2) AS average_quarterly_orders,
  ROUND(AVG(sales_volume),2) AS average_quarterly_sales
FROM quarterly_metrics
GROUP BY region
ORDER BY 2 DESC, 3 DESC
;



