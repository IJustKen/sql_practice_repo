select distinct t1.num as ConsecutiveNums  -- avoid dupes
from Logs t1
inner join Logs t2
on t1.id + 1 = t2.id and t1.num = t2.num  -- this join to filter the numbers which come at least 2 times consecutive
inner join Logs t3
on t2.id + 1 = t3.id and t2.num = t3.num;  -- this to filter the ones which come 3 times
