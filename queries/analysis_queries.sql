

-- 1. Which restaurants generate the highest revenue?

-- Top 10 revenue-generating restaurants
SELECT 
    r.restaurant_id,
    r.name AS restaurant_name,
    r.city,
    SUM(o.total_amount) AS total_revenue,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(r.avg_rating), 2) AS avg_rating  -- AVG() used to comply with GROUP BY; value is already constant per restaurant.

FROM
    restaurants AS r
        JOIN
    orders AS o ON r.restaurant_id = o.restaurant_id
WHERE
    o.status = 'Delivered' -- only count vaild completed orders
GROUP BY r.name , r.city , r.restaurant_id
ORDER BY total_revenue DESC
LIMIT 10;      -- show top 10




-- 2. What are the most ordered menu items across the platform?

-- Most frequently ordered menu items across the platform
SELECT 
    m.item_name, -- name of menu item
    COUNT(o.item_id) AS order_count,   -- how many time it appeared in order
    SUM(o.quantity) AS total_quantity -- total item order
FROM
    menu_items AS m
        JOIN
    order_items AS o ON m.item_id = o.item_id
GROUP BY m.item_id , m.item_name
ORDER BY order_count DESC
LIMIT 10; -- top 10 order appeared




-- 3. Which cities show the highest order volume?

-- Order volume by city
SELECT 
    r.city, 
    COUNT(order_id) AS total_order -- number of order in cities
FROM
    restaurants AS r
        JOIN
    orders AS o ON r.restaurant_id = o.restaurant_id
GROUP BY r.city -- each row by city
ORDER BY total_order DESC; -- highest ordering city first




-- 4. Who are the top 10 highest-spending customers?

-- Top customers ranked by total spending
SELECT 
    c.customer_id,
    c.customer_name, 
    SUM(o.total_amount) AS total_spend, -- total money spent
    COUNT(order_id) AS total_order -- number of order placed
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
WHERE
    o.status = 'Delivered'  -- only count successful orders
GROUP BY c.customer_id , c.customer_name
ORDER BY total_spend DESC
LIMIT 10;   -- top 10 




-- 5. What cuisines are most popular based on order volume?

-- Most popular cuisines by order volume
SELECT 
    c.cuisine_name, -- type of cuisine
    COUNT(order_id) AS total_order 
FROM
    orders AS o
        JOIN
    restaurants AS r ON o.restaurant_id = r.restaurant_id
        JOIN
    restaurant_cuisines AS rc ON r.restaurant_id = rc.restaurant_id
        JOIN
    cuisines AS c ON rc.cuisine_id = c.cuisine_id
WHERE
	o.status = 'Delivered' -- only successful orders
GROUP BY c.cuisine_name
ORDER BY total_order DESC
LIMIT 10;    -- top 10





-- 6. What hours of the day see the highest number of orders?

-- Peak ordering hours across the platform
SELECT 
    HOUR(order_time) AS order_hour, -- hour of the day (0-23)
    COUNT(order_id) AS total_orders
FROM
    orders
WHERE
    status = 'Delivered' -- only include completed orders
GROUP BY order_hour
ORDER BY total_orders DESC;





-- 7. Do high-rated restaurants earn more revenue than low-rated ones?

-- Does a higher rating correlate with higher revenue?
SELECT 
    r.name, -- restaurant name
    CASE
        WHEN avg_rating >= 4.5 THEN 'Excellent (4.5 - 5.0)'
        WHEN avg_rating >= 4.0 THEN 'Good (4.0 - 4.4)'
        WHEN avg_rating >= 3.5 THEN 'Average (3.5 - 3.9)'
        ELSE 'Low (< 3.5)'
    END rating_band,            -- rating groups
    SUM(o.total_amount) AS total_amount,
    ROUND(AVG(r.avg_rating), 2) AS avg_rating
FROM
    restaurants AS r
        JOIN
    orders AS o ON r.restaurant_id = o.restaurant_id
WHERE
    o.status = 'Delivered'  -- only successful orders
GROUP BY r.name , rating_band
ORDER BY total_amount DESC
LIMIT 5;                  -- top 5





-- 8. Which restaurants have declining ratings over time?

-- Identify restaurants whose ratings drop over time
WITH rating_trend AS (
    SELECT
        rt.restaurant_id,
        r.name AS restaurant_name,
        rt.rating,
        rt.rating_time,
        
        LAG(rt.rating) OVER (
            PARTITION BY rt.restaurant_id 
            ORDER BY rt.rating_time
        ) AS prev_rating
    FROM ratings rt
    JOIN restaurants r 
          ON rt.restaurant_id = r.restaurant_id
)

SELECT 
    restaurant_id,
    restaurant_name,
    COUNT(*) AS decline_count   -- how many times the rating decreased
FROM rating_trend
WHERE prev_rating IS NOT NULL   -- ignore the first rating of each restaurant
  AND rating < prev_rating      -- drop detected
GROUP BY restaurant_id, restaurant_name
ORDER BY decline_count DESC;    -- worst performers first




-- 9. Which customers show repeat behaviour (loyal customers)?

-- Identify loyal customers based on repeat orders
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_order -- number of orders delivered
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
WHERE
    o.status = 'Delivered'
GROUP BY c.customer_id , c.customer_name
HAVING COUNT(o.order_id) >= 2  -- threshold for loyalty
ORDER BY total_order DESC;  -- most loyal customer first





-- 10. Which restaurants have the highest average order value (AOV)?

-- Restaurants ranked by highest Average Order Value (AOV)
SELECT 
    
    r.name AS restaurant_name,
    r.city,
    SUM(o.total_amount) AS total_revenue,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount) / COUNT(o.order_id),
            2) AS avg_order_value  -- AOV
FROM
    restaurants AS r
        JOIN
    orders AS o ON r.restaurant_id = o.restaurant_id
WHERE
    o.status = 'Delivered'
GROUP BY  r.name , r.city
HAVING total_orders > 0
ORDER BY avg_order_value DESC;




