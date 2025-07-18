-- Write your PostgreSQL query statement below

--select customer.name from customer where customer.name not in (select customer.name from customer where customer.referee_id=2 );

-- the above wont work if name is null. NOT IN doesnt do well when there is null inside hence use NOT EXISTS maybe.

select customer.name from customer where customer.referee_id != 2 or customer.referee_id is null;

--make sure to return even null wale as not everyone gonna have a referee no
