# https://leetcode.com/problems/nth-highest-salary/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      with highest_salary as (
          select distinct salary from Employee order by salary desc limit N
      )
      select
          case
             when
                (select count(*) from highest_salary) >= N then salary
            else
                null
          end
      from highest_salary order by salary asc limit 1
  );
END