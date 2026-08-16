-- single table scan method
select
    to_char(trans_date::date, 'YYYY-MM') as month,
    country,
    count(*) as trans_count,
    count(*) filter (where state = 'approved') as approved_count,    -- aggregate() filter (where ..) is the syntax for this one
    sum(amount) as trans_total_amount,
    coalesce(sum(amount) filter (where state = 'approved'), 0) as approved_total_amount
from Transactions group by month, country;


-- 2 CTEs means 2 table scans and then 2 coalesce in every single row scan later, can get less efficient
with approved_trans as 
(
    select count(t.id) as approved_count, sum(t.amount) as approved_total_amount, t.country, to_char(t.trans_date::date, 'YYYY-MM') as month 
    from Transactions t 
    where t.state = 'approved' 
    group by month, t.country
), -- CTE V IMP NEVER WRITE "WITH" AGAIN, just separate with commas that is enough
    -- USE to_char(date_type, 'YYYY-MM' or 'Jan-YYYY' and stuff) to get the month-year and other combos from a date
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
-- one edge case was when country itself has a null value, in that case simply doing t.country = a.country will fail
-- because null = null does not give true it gives null.
-- thus the coalesce checks when it is null in both it becomes "na", which is then compared and returns TRUE.
