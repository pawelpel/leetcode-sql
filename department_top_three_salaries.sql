# https://leetcode.com/problems/department-top-three-salaries/
WITH ranked_salaries AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (
            PARTITION BY d.id
            ORDER BY e.salary DESC
        ) as given_rank
    FROM Employee e LEFT JOIN Department d ON e.departmentId = d.id
)
SELECT Department, Employee, Salary FROM ranked_salaries WHERE given_rank < 4 ORDER BY Salary DESC