-- more optimized approach, almost same as the original approach but here
-- while joining I joined on the second login = first login + 1 day condition
-- this way we do not have unnecessary memory overhead during the left join which is more fast
with first_logins as
(
    select 
        player_id, 
        min(event_date) as first_login 
    from Activity
    group by player_id
)

select 
    round((count(a.player_id)::decimal/(select count(*) from first_logins)), 2) as fraction
from first_logins f
left join Activity a
on f.player_id = a.player_id
and f.first_login + interval '1 day' = a.event_date;    -- here we use INTERVAL '1 day' instead of directly integer 1

    

-- CTE to just get the first logins first
with first_logins as
(
    select 
        player_id, 
        min(event_date) as first_login 
    from Activity
    group by player_id
)

-- then join the CTE and the actual table and count the total first logins and the total second logins which were only a day after the first login
select 
    round(count(*) filter (where a.event_date - f.first_login = 1)::decimal/count(*) filter (where f.first_login = a.event_date), 2) as fraction
from first_logins f
left join Activity a
on f.player_id = a.player_id;
