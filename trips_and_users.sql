# https://leetcode.com/problems/trips-and-users/
with filtered_trips as (
    select
        t.request_at as trip_day,
        case when t.status <> 'completed' then 1 else null end as cancelled
    from Trips t
        left join Users client on t.client_id = client.users_id
        left join Users driver on t.driver_id = driver.users_id
    where
        t.request_at between '2013-10-01' and '2013-10-03' and
        ( client.users_id is null or client.banned = 'No') and
        ( driver.users_id is null or driver.banned = 'No')
)
select
    f.trip_day as Day,
    round(count(f.cancelled) / count(*), 2) as 'Cancellation Rate'
from filtered_trips f group by f.trip_day