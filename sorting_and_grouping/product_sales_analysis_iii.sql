with first_sales as -- CTE to get all the first sales for each product id so we get each product id along with the first year it was sold
(
    select 
        product_id, 
        min(year) as first_year 
    from Sales
    group by product_id
)

select 
    f.product_id, 
    f.first_year, 
    s.quantity, 
    s.price
from first_sales f
inner join Sales s
on f.product_id = s.product_id
and f.first_year = s.year;  -- join on both product id and year so as to get the multiple instances of the same product being purchase in the same year
