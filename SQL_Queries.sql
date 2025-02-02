-- top 3 customers based on orders
select c.first_name, c.last_name,
sum(o.total_amount) as total_order_amount
from Customers as c
join Orders as o on o.customer_id = c.customer_id
group by c.customer_id
order by total_order_amount desc
limit 3;

-- average order value for each customer
select c.first_name, c.last_name,
avg(o.total_amount) as average_order_amount
from Customers as c
join Orders as o on o.customer_id = c.customer_id
group by c.customer_id
order by average_order_amount desc;

-- employees with >4 resolved ticket support
select e.first_name, e.last_name,
count(sp.ticket_id) as resolved_ticket
from Employees as e
join SupportTickets as sp on sp.employee_id = e.employee_id
where sp.status = 'resolved'
group by e.employee_id
having resolved_ticket > 4;

-- the product that never buys
select p.product_name
from Products as p
left join OrderDetails as od on od.product_id = p.product_id
where od.order_id is null;

-- total revenue from product sales
 select sum(quantity*unit_price) from OrderDetails;
 
 -- average for each product category
 with cte_avg_price as (	/*cte (common table expression) = table sementara*/ 
 select category, avg(price) as rerata
 from Products
 group by category
 )
 select * from cte_avg_price where rerata > 500
 ;
 
 -- find customers who have one order with total > 1000 
select * from Customers
where customer_id in
(select customer_id
from Orders
where total_amount > 1000);