# https://leetcode.com/problems/department-highest-salary/

with ranked_salaries as (
    select
        d.name as Department,
        e.name as Employee,
        e.salary as Salary,
        rank() over (partition by d.name order by e.salary desc) as salary_rank
    from Employee e
         join Department d on e.departmentId = d.id
)
select Department, Employee, Salary from ranked_salaries where salary_rank = 1;