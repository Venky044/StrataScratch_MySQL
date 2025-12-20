--               Highest Cost Orders

-- Find the customers with the highest daily total order cost between 2019-02-01 and 2019-05-01. 
-- If a customer had more than one order on a certain day, sum the order costs on a daily basis. 
-- Output each customer's first name, total cost of their items, and the date. 
-- If multiple customers tie for the highest daily total on the same date, return all of them.

-- Tables:

-- customers
--     id: bigint
--     first_name: text
--     last_name: text
--     city: text
--     address: text
--     phone_number: text

-- orders
-- id: bigint
-- cust_id: bigint
-- order_date: date
-- order_details: text
-- total_order_cost: bigint

-- Solution:
WITH customer_totals AS (
    SELECT 
        o.order_date,
        o.cust_id,
        SUM(o.total_order_cost) AS total_cost
    FROM orders o
    WHERE o.order_date BETWEEN '2019-02-01' AND '2019-05-01'
    GROUP BY o.order_date, o.cust_id
),
max_per_day AS (
    SELECT 
        order_date,
        MAX(total_cost) AS max_cost
    FROM customer_totals
    GROUP BY order_date
)

SELECT 
    ct.order_date,
    c.first_name,
    ct.total_cost AS max_cost
FROM customer_totals ct
JOIN max_per_day mp 
    ON ct.order_date = mp.order_date 
   AND ct.total_cost = mp.max_cost
JOIN customers c 
    ON c.id = ct.cust_id
ORDER BY ct.order_date;
