                  -- Rank Variance Per Country

-- Compare the total number of comments made by users in each country during December 2019 and January 2020.

-- For each month, rank countries by their total number of comments in descending order. 
-- Countries with the same total should share the same rank, and the next rank should increase by one (without skipping numbers).

-- Return the names of the countries whose rank improved from December to January (that is, their rank number became smaller).

-- Tables:
--       fb_comments_count
-- user_id: bigint
-- created_at: date
-- number_of_comments: bigint
  
--       fb_active_users
-- user_id: bigint
-- name: text
-- status: text
-- country: text

-- Solutions:
with total_comments As (
    select 
        fu.country,
        sum(case when created_at between "2019-12-01" and "2019-12-31" then fc.number_of_comments else 0 end) as Dec_count,
        sum(case when created_at between "2020-01-01" and "2020-01-31" then fc.number_of_comments else 0 end) as Jan_count
    from fb_active_users fu
    inner join fb_comments_count fc on fu.user_id = fc.user_id
    group by fu.country
),
c_rank as (
    select 
        country,
        DENSE_RANK() over(order by Dec_count desc) as Dec_rank,
        DENSE_RANK() over(order by Jan_count desc) as Jan_rank
    from total_comments
)
select
    country
from c_rank
where Jan_rank < Dec_rank;
