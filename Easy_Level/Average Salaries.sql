                  -- Average Salaries

-- Compare each employee's salary with the average salary of the corresponding department.
-- Output the department, first name, and salary of employees along with the average salary of that department.

-- Table:- employee
--   address: text
--   age: bigint
--   bonus: bigint
--   city: text
--   department: text
--   email: text
--   employee_title: text
--   first_name: text
--   id: bigint
--   last_name: text
--   manager_id: bigint
--   salary: bigint
--   sex: text
--   target: bigint

-- Output:
-- department	first_name	salary	avg_salary
-- Audit	      Shandler	   1100	    950
-- Audit	      Jason	       1000	    950
-- Audit	      Celine	     1000	    950

Solutions:
-- 1.
select e1.department, e1.first_name, e1.salary, e2.dept_avg_salary
from employee e1
left join (select department, avg(salary) as dept_avg_salary 
            from employee
            group by department) e2
        on e1.department = e2.department;

-- 2:
with dept_sal as (
    select department, avg(salary) as dept_avg_salary
    from employee
    group by department
)
select e.department, e.first_name, e.salary, d.dept_avg_salary
from employee e
left join dept_sal d
    on e.department = d.department;
