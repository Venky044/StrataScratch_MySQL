--                 Consecutive Days

-- Find all the users who were active for 3 consecutive days or more.

-- Table: sf_events
-- record_date: date
-- account_id: text
-- user_id: text

-- ex:
-- record_date	account_id	user_id
-- 2021-01-01	A1	        U1
-- 2021-01-01	A1	        U2

-- Solutions
with sample as (
    select 
        user_id,
        lag(record_date) over(partition by user_id order by record_date) as "P_d",
        lead(record_date) over(partition by user_id order by record_date) as "N_d"
    from sf_events),
sample2 as (
    select user_id, datediff(N_d, P_d) as con_days
    from sample
    )

select distinct(user_id) as "user_id"
from sample2
where con_days = 2;

-- or
with sample as (
    select 
        user_id,
        lag(record_date) over(partition by user_id order by record_date) as "P_d",
        lead(record_date) over(partition by user_id order by record_date) as "N_d"
    from sf_events)

select distinct(user_id) as "user_id"
from sample
where datediff(N_d, P_d) = 2;
