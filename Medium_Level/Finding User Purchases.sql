--               Finding User Purchases

-- Identify returning active users by finding users who made a second purchase within 1 to 7 days after their first purchase. 
-- Ignore same-day purchases. Output a list of these user_ids.

-- Table: amazon_transactions
-- id: bigint
-- user_id: bigint
-- item: text
-- created_at: date
-- revenue: bigint

-- Solution:
with sample as (
select 
    user_id,
    First_value(created_at) over(partition by user_id order by created_at asc) as "first_date",
    lead(created_at) over(partition by user_id order by created_at asc) as "Next_date"
from amazon_transactions)

select distinct(user_id) as "user_id"
from sample
where first_date != Next_date 
        and datediff(Next_date, first_date) <= 7;

-- or "Without using Window Functions"
with sample as (
    select user_id, min(created_at) as "first_date"
    from amazon_transactions
    group by user_id
)
select distinct(t1.user_id)
from sample t1
inner join amazon_transactions t2
    on t1.user_id = t2.user_id
    and t1.first_date != t2.created_at
    and datediff(t2.created_at, t1.first_date) <= 7;
