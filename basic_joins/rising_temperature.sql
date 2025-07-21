-- Write your PostgreSQL query statement below

select today.id
from weather today 
cross join weather yesterday    --this is like cartesian product so you get all possible date combos
where today.recordDate - yesterday.recordDate = 1        --filter condition
and today.temperature > yesterday.temperature;
