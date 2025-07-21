-- Write your PostgreSQL query statement below

select today.id
from weather today 
cross join weather yesterday    --this is like cartesian product so you get all possible date combos
where today.recordDate - yesterday.recordDate = 1        --filter condition
and today.temperature > yesterday.temperature;

select today.id              --MUCH FASTER BECAUSE NO CROSS JOIN, cross join is more time consuming cuz you joining every possible val first and then filtering unlike with join on
from weather today 
join weather yesterday
on yesterday.recordDate + interval '1 DAY' = today.recordDate
and today.temperature > yesterday.temperature;
