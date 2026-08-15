-- Write your PostgreSQL query statement below
with approved_trans as 
(
    select count(t.id) as approved_count, sum(t.amount) as approved_total_amount, t.country, to_char(t.trans_date::date, 'YYYY-MM') as month 
    from Transactions t 
    where t.state = 'approved' 
    group by month, t.country
),
total_trans as
(
    select count(t.id) as trans_count, sum(t.amount) as trans_total_amount, t.country, to_char(t.trans_date::date, 'YYYY-MM') as month 
    from Transactions t 
    group by month, t.country
)

select t.month, t.country, t.trans_count, coalesce(a.approved_count, 0) as approved_count, t.trans_total_amount, coalesce(a.approved_total_amount, 0) as approved_total_amount
from total_trans t 
left join approved_trans a 
on coalesce(t.country, 'na') = coalesce(a.country, 'na') and t.month = a.month;
