# https://leetcode.com/problems/consecutive-numbers/

with next_three_nums as (
    select
        l.id,
        l.num,
        lead(l.num, 1) over (
            order by l.id
        ) as next_num_1,
        lead(l.num, 2) over (
            order by l.id
        ) as next_num_2
    from Logs l
)
select distinct num as ConsecutiveNums from next_three_nums
where num = next_num_1 and next_num_1 = next_num_2
