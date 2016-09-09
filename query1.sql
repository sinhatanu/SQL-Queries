-- Write a SQL query to find the products which have not been sold yet.

-- 1st method

SELECT product_name
FROM products
WHERE product_id NOT IN
  (SELECT DISTINCT product_id FROM sales
  );

-- 2nd method

SELECT p.product_name
FROM products p
LEFT OUTER JOIN sales s
ON p.product_id   = s.product_id
WHERE s.quantity IS NULL;

-- 3rd method

SELECT product_name
FROM products p
WHERE NOT EXISTS
  (SELECT 1 FROM sales s WHERE s.product_id = p.product_id
  );

--Script Outputs for above three queries
/*PRODUCT_NAME                 
------------------------------
Motorola                       

PRODUCT_NAME                 
------------------------------
Motorola                       

PRODUCT_NAME                 
------------------------------
Motorola */                     



