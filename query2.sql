--Write a SQL query to find the products whose sales decreased in 2014 compared to 2013?
-- below one is way too complex but gets the right result

SELECT product_name
FROM
  (SELECT p.product_name,
    lead(s.quantity,1,0)over (partition BY s.product_id order by s.year nulls last)next_year_quantity,
    (s.quantity - lead(s.quantity,1,0)over (partition BY s.product_id order by s.year nulls last))change_quantity
  FROM sales s,
    products p
  WHERE s.year    IN (2013,2014)
  AND p.product_id = s.product_id
  ORDER BY s.product_id,
    s.year ASC
  )t
WHERE t.change_quantity >0
AND t.next_year_quantity>0;

--2nd easier method:

SELECT p.product_name
FROM products p,
  (SELECT product_id,quantity FROM sales WHERE YEAR = 2013
  )s_13,
  (SELECT product_id,quantity FROM sales WHERE YEAR = 2014
  )s_14
WHERE p.product_id      = s_13.product_id
AND s_13.product_id = s_14.product_id
AND s_13.quantity     > s_14.quantity;
 
--3rd more compact way of doing it:

SELECT p.product_name
FROM products p,
  sales s_13,
  sales s_14
WHERE p.product_id  = s_13.PRODUCT_ID
AND s_13.year       = 2013
AND s_14.YEAR       = 2014
AND s_13.PRODUCT_ID = s_14.PRODUCT_ID
AND s_13.QUANTITY   > s_14.QUANTITY;

--Script Output
/*
PRODUCT_NAME                 
------------------------------
Samsung                        
Nokia                          
BlackBerry                     

PRODUCT_NAME                 
------------------------------
Samsung                        
Nokia                          
BlackBerry                     

PRODUCT_NAME                 
------------------------------
Samsung                        
Nokia                          
BlackBerry                     

*/
