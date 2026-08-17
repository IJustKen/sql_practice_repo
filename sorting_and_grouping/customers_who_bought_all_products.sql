-- Simpler method no need for CTE just use having
select
    customer_id
from Customer
group by customer_id
having count(distinct product_key) = (select count(*) from Product);
-- thing to know is that a singular value like select count(*) from Product is calculated ONCE, then each new time the calculation is asked
-- it takes it from the cache. So it is internally optimized in SQL dw.


-- CTE method that I originally thought of
with product_counter as
(
    select 
        c.customer_id,
        count(distinct c.product_key) filter (where c.product_key in (select * from Product)) as products_bought
    from Customer c
    group by c.customer_id
)
select 
    customer_id 
from product_counter
where products_bought = (select count(product_key) from Product);
