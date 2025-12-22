--               Risky Projects

-- You are given a set of projects and employee data. Each project has a name, a budget, and a specific duration, 
-- while each employee has an annual salary and may be assigned to one or more projects for particular periods. 
-- The task is to identify which projects are overbudget. A project is considered overbudget 
-- if the prorated cost of all employees assigned to it exceeds the project’s budget.

-- To solve this, you must prorate each employee's annual salary based on the exact period they work on a given project, 
-- relative to a full year. For example, if an employee works on a six-month project, 
-- only half of their annual salary should be attributed to that project. 
-- Sum these prorated salary amounts for all employees assigned to a project and compare the total with the project’s budget.

-- Your output should be a list of overbudget projects, where each entry includes the project’s name, its budget, 
-- and the total prorated employee expenses for that project. The total expenses should be rounded up to the nearest dollar. 
-- Assume all years have 365 days and disregard leap years.

-- Tables

-- linkedin_projects:
-- id: bigint
-- title: text
-- budget: bigint
-- start_date: date
-- end_date: date
                
-- linkedin_emp_projects:
-- emp_id: bigint
-- project_id: bigint
                
-- linkedin_employees:
-- id: bigint
-- first_name: text
-- last_name: text
-- salary: bigint

-- Solutions:
select 
    lp.title,
    lp.budget,
    ceil(datediff(lp.end_date, lp.start_date) * (sum(salary)/365)) as prorated_employee_expense
from linkedin_projects lp
inner join linkedin_emp_projects lep on lp.id = lep.project_id
inner join linkedin_employees le on lep.emp_id = le.id
group by lp.id, lp.title, lp.budget
having lp.budget < prorated_employee_expense;

-- or 

with daywise_sal as (
    select project_id, sum(salary)/365 as per_day_salary
    from linkedin_employees le
    inner join linkedin_emp_projects lep on le.id = lep.emp_id
    group by project_id
),
projects_days as (
    select id, title, budget, datediff(end_date, start_date) as no_days
    from linkedin_projects
),
expense as (
    select title, budget, ceil(no_days*per_day_salary) as prorated_employee_expense
    from projects_days pd
    inner join daywise_sal ds on pd.id = ds.project_id
)
select * 
from expense
where budget < prorated_employee_expense;
