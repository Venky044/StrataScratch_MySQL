                  -- Workers With The Highest Salaries

-- Management wants to analyze only employees with official job titles. 
-- Find the job titles of the employees with the highest salary. 
-- If multiple employees have the same highest salary, include all their job titles.

-- Tables:
--       worker
-- worker_id: bigint
-- first_name: text
-- last_name: text
-- salary: bigint
-- joining_date: date
-- department: text
  
--       title
-- worker_ref_id: bigint
-- worker_title: text
-- affected_from: date

-- Solution:

with worker_data As (
    select *
    from title t
    inner join worker w on t.worker_ref_id = w.worker_id
)
select distinct(worker_title)
from worker_data
where salary = (select max(salary) from worker_data);
