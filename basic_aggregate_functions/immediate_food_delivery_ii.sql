-- CTE to just get the "first orders" of all users
with first_orders as
(
    select  
        customer_id, 
        min(order_date) as earliest_order
    from Delivery
    group by customer_id
)

-- count with filter where the first order date and preferred delivery dates match. Also count all the first orders
-- simple now divide and multiply by 100
select 
    round((count(*) filter (where f.earliest_order = d.customer_pref_delivery_date)::decimal/count(*))*100, 2) as immediate_percentage
from first_orders f 
left join Delivery d 
on f.earliest_order = d.order_date and f.customer_id = d.customer_id;
