                -- Finding Updated Records

-- We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. 
-- Find the current salary of each employee assuming that salaries increase each year. 
-- Output their id, first name, last name, department ID, and current salary. 
-- Order your list by employee ID in ascending order.

-- Table: ms_employee_salary

-- id: bigint
-- first_name: text
-- last_name: text
-- salary: bigint
-- department_id: bigint

-- Solution: 
select id, first_name, last_name, department_id, salary
from (
    select 
        id, first_name, last_name, 
        department_id, salary,
        Row_Number() over(partition by id order by salary desc) as rn
    from ms_employee_salary) a
where a.rn = 1
order by id;
