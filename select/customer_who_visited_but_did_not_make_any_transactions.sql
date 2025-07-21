-- Write your PostgreSQL query statement below

select v.customer_id,count(v.visit_id) as count_no_trans 
from visits v 
where v.visit_id not in (select t.visit_id from transactions t)    --if visit_id is in transactions it means pakka they bought 
                                                                  --something so remove it
group by v.customer_id 
order by count(v.visit_id);
