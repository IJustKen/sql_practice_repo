-- Write your PostgreSQL query statement below

--postgresql uses round(x) which takes one arg and gives the nearest whole num
-- the other is round(x,y) which takes numeric, integer so gotta type cast in case it isn't that
-- cast(num or expression AS float/numeric/int..) or use (num or expression)::float/numeric/int...

select a1.machine_id, round(avg(a2.timestamp - a1.timestamp)::numeric,3) as processing_time
from activity a1 join activity a2 
on a1.machine_id = a2.machine_id 
and a1.process_id = a2.process_id         -- get the same machine and process
and a1.activity_type = 'start'            
and a1.activity_type != a2.activity_type    -- these 2 combined mean get the pairs of start and end
group by a1.machine_id;
