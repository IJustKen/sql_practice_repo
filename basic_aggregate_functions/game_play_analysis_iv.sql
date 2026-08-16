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
