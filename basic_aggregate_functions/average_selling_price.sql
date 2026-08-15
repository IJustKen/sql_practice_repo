-- Write your PostgreSQL query statement below
-- coalesce is new it is like
-- coalesce(val1, val2, val3, val4) it returns the first non NULL value in this order
-- if all are NULL it will return NULL, thus make sure the last argument is like a non NULL thing else no point using this
-- NULLIF(arg1, arg2) returns arg1 if arg1 != arg2. But if they are equal it returns NULL
select p.product_id, round(
    coalesce(sum(p.price*u.units)::decimal/nullif(sum(u.units), 0), 0), 2
    ) as average_price 
from Prices p left join UnitsSold u on p.product_id = u.product_id and u.purchase_date between p.start_date and p.end_date group by p.product_id;
