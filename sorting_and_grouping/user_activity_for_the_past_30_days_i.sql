with monthly_users as  --CTE for getting users for 30 days from 2019-07-27 to 30 days before that
(
    select * from Activity where activity_date <= '2019-07-27'::date and activity_date > '2019-07-27'::date - interval '30 days'
)
-- then count unique users and group by date
select activity_date as day, count(distinct user_id) as active_users from monthly_users group by activity_date;
