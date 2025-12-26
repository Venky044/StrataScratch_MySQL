--                   Salaries Differences

-- Calculates the difference between the highest salaries in the marketing and engineering departments. 
-- Output just the absolute difference in salaries.
-- Table: 
--   db_employee
-- id: bigint
-- first_name: text
-- last_name: text
-- salary: bigint
-- department_id: bigint

--   db_dept
-- id: bigint
-- department: text

-- Solution:
with sample as (
    select 
    max(case when department = "engineering" then salary else 0 end) as max_eng_sal,
    max(case when department = "marketing" then salary else 0 end) as max_mar_sal
    from db_employee de
    inner join db_dept dp on de.department_id = dp.id
)
select
    abs(max_eng_sal - max_mar_sal) as sal_diff
from sample;
