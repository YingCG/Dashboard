-- customer who go over credit limit
-- a breakdown of each customer and their sales, include a money owned column as we would like to see if any customers have gone over thier credit limit.

-- with cte_sales as
-- (
-- select
-- orderDate, 
-- t1.customerNumber, 
-- t1.orderNumber,
-- customerName, 
-- productCode, 
-- creditLimit,
--  quantityOrdered * priceEach as sales_value
-- from orders t1
-- inner join orderdetails t2
-- on t1.orderNumber = t2.orderNumber
-- inner join customers t3
-- on t1.customerNumber = t3.customerNumber
-- )
-- select * from cte_sales

-- to sum the sales _value and for each order date and customers
-- select orderDate, orderNumber, customerNumber, customerName, creditLimit, sum(sales_value) as sales_value
-- from cte_sales
-- group by orderDate, orderNumber, customerNumber, customerName, creditLimit


-- to sum each customer number with their sales_value
-- with cte_sales as
-- (
-- select
-- orderDate, 
-- t1.customerNumber, 
-- t1.orderNumber,
-- customerName, 
-- productCode, 
-- creditLimit,
--  quantityOrdered * priceEach as sales_value
-- from orders t1
-- inner join orderdetails t2
-- on t1.orderNumber = t2.orderNumber
-- inner join customers t3
-- on t1.customerNumber = t3.customerNumber
-- ),
-- running_total_sales_cte as
-- (
-- select orderDate, orderNumber, customerNumber, customerName, creditLimit, sum(sales_value) as sales_value
-- from cte_sales
-- group by 
-- orderDate, orderNumber, customerNumber, customerName, creditLimit
-- )

-- select *, row_number() over (partition by customernumber order by orderdate) as purchase_num from running_total_sales_cte
-- select *, sum(sales_value) over (partition by customernumber order by orderdate) as running_total_sales
-- from running_total_sales_cte

-- bring the payments
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
(
select orderDate, orderNumber, customerNumber, customerName, creditLimit, sum(sales_value) as sales_value
from cte_sales
group by orderDate, orderNumber, customerNumber, customerName, creditLimit
),
payments_cte as
(select *, sum(amount) over (partition by customerNumber order by paymentDate) as running_total_payment from payments)

select * ,
sum(sales_value) over (partition by t1.customernumber order by orderdate) as running_total_sales
from  running_total_sales_cte t1
left join payments_cte t2
on t1.customerNumber= t2.customerNumber
where t1.customerNumber = 103
 
 
