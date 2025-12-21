--           New Products
-- Calculate the net change in the number of products launched by companies in 2020 compared to 2019. 
-- Your output should include the company names and the net difference.
-- (Net difference = Number of products launched in 2020 - The number launched in 2019.)

-- Table: car_launches
-- Columns
-- year: bigint
-- company_name: text
-- product_name: text

-- ex:
-- year	company_name	product_name
-- 2019	Toyota	      Avalon
-- 2019	Toyota	      Camry

-- Solution
with sample as (
    select 
        company_name,
        count(distinct case when year = 2020 then product_name else null end) as 2020_count,
        count(distinct case when year = 2019 then product_name else null end) as 2019_count
    from car_launches
    group by company_name)
    
select company_name, (2020_count - 2019_count) as total_launch
from sample;
