-- Write your MySQL query statement below

select unique_id,name 
from employeeuni eu 
right join employees e 
on e.id = eu.id;
