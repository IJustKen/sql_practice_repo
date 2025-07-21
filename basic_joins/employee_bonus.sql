-- Write your PostgreSQL query statement below

select e.name, b.bonus 
from employee e
left join bonus b
on e.empId = b.empId
where b.bonus<1000 or b.bonus is null;  --dont use b.bonus = null as there is no "comparison" with null ever
                                        -- this aint python
