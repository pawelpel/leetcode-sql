# https://leetcode.com/problems/human-traffic-of-stadium/
with people_100 as (
    select id from Stadium where people >= 100
),
avgs as (
    select
        id,
        avg(id) over (
            rows between current row and 2 following
        ) as avg_of_c23,
        count(id) over (
            rows between current row and 2 following
        ) as count_c23,
        avg(id) over (
            rows between 1 preceding and 1 following
        ) as avg_of_1c3,
        count(id) over (
            rows between 1 preceding and 1 following
        ) as count_1c3,
        avg(id) over (
            rows between 2 preceding and current row
        ) as avg_of_12c,
        count(id) over (
            rows between 2 preceding and current row
        ) as count_12c
    from people_100
)
select s.* from Stadium s join avgs a
where
    (a.avg_of_c23 = s.id + 1 and a.count_c23 = 3) or
    (a.avg_of_1c3 = s.id     and a.count_1c3 = 3) or
    (a.avg_of_12c = s.id - 1 and a.count_12c = 3)