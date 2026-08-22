-- faster method single pass, CTE + window function
with chosen_rows as 
(
    select 
        num,
        lead(num, 1) over (order by id) as num_next,  -- this chooses the row 1 row after the current one
        lead(num, 2) over (order by id) as num_nnext  -- ordering by id makes sure these nums are consecutive even if there are gaps between id
    from Logs
)
-- made CTE because lead() as num_next gets evaluated AFTER the where keyword, so num_next n all do not exist to filter anything 
select distinct num as ConsecutiveNums
from chosen_rows
where num = num_next and num = num_nnext;  -- condition to get 3 consecutive


-- sequential joining method
select distinct t1.num as ConsecutiveNums  -- avoid dupes
from Logs t1
inner join Logs t2
on t1.id + 1 = t2.id and t1.num = t2.num  -- this join to filter the numbers which come at least 2 times consecutive
inner join Logs t3
on t2.id + 1 = t3.id and t2.num = t3.num;  -- this to filter the ones which come 3 times
