-- an overview of sales for 2004, breakdown by product, country and city, include the sales value, cost of sales and net profit


-- step 1 join all the necessary table to get the data --
-- select * 
-- from orders t1
-- inner join orderdetails t2
-- on t1.orderNumber = t2.orderNumber
-- inner join products t3
-- on t2.productCode = t3.productCode
-- inner join customers t4
-- on t1.customerNumber = t4.customerNumber

-- step 2 select the column we need--
select t1.orderDate, t1.orderNumber ,quantityOrdered, priceEach, productName, productLine , buyPrice, country, city
from orders t1
inner join orderdetails t2
on t1.orderNumber = t2.orderNumber
inner join products t3
on t2.productCode = t3.productCode
inner join customers t4
on t1.customerNumber = t4.customerNumber

-- show only 2014
where year(orderDate) = 2004

-- then we do calculation of buyprice * quantity Order, and name column as cost of sales. we can also do in excel
-- select a row from resulat, then click on top left corner to select everyting and paste value to excel
-- create overview using pivot table

