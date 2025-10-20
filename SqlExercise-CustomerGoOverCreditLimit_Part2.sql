with cte_sales as
(
select
orderDate, 
t1.customerNumber, 
t1.orderNumber,
customerName, 
productCode, 
creditLimit,
 quantityOrdered * priceEach as sales_value
from orders t1
inner join orderdetails t2
on t1.orderNumber = t2.orderNumber
inner join customers t3
on t1.customerNumber = t3.customerNumber
),
running_total_sales_cte as
(select *, lead(orderDate) over (partition by customerNumber order by orderDate) as next_order_date
from 
(
select orderDate, orderNumber, customerNumber, customerName, creditLimit, sum(sales_value) as sales_value
from cte_sales
group by orderDate, orderNumber, customerNumber, customerName, creditLimit
) 
subquery
),

payments_cte as
(select * from payments),

main_cte as
(
select t1.* ,
sum(sales_value) over (partition by t1.customernumber order by orderdate) as running_total_sales,
sum(amount) over (partition by t1.customerNumber order by orderDate) as running_total_payment
from  running_total_sales_cte t1
left join payments_cte t2

-- to add the condition that payment date is between order date and next order date
-- on t1.customerNumber= t2.customerNumber and t2.paymentdate between t1.orderdate and t1.next_order_date

-- to add a condition when next order date is null, then use current date
on t1.customerNumber = t2.customerNumber and t2.paymentdate between t1.orderdate 
and case when t1.next_order_date is null then current_date else next_order_date end
)

select *, running_total_sales - running_total_payment as money_owed,
creditlimit - ( running_total_sales - running_total_payment) as difference
 from main_cte
 
 -- from this, those with minus on difference is gone over the limit