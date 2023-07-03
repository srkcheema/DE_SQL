SELECT order_id, customer_id, product_id, purchase_date, order_amount
FROM sales_data_source
WHERE purchase_date >= '2023–01–01';

WITH transformed_sales_data AS (
 SELECT order_id, customer_id, product_id, purchase_date, order_amount,
 CASE
 WHEN order_amount > 1000 THEN 'High-value'
 WHEN order_amount > 500 THEN 'Medium-value'
 ELSE 'Low-value'
 END AS order_category
 FROM extracted_sales_data
)
SELECT *
FROM transformed_sales_data;

INSERT INTO sales_data_warehouse (order_id, customer_id, product_id, purchase_date, order_amount, order_category)
SELECT order_id, customer_id, product_id, purchase_date, order_amount, order_category
FROM transformed_sales_data;

