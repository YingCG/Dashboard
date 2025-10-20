create or replace view sales_data_for_power_bi as 

select orders.orderDate, 
orders.orderNumber, 
products.productName, 
products.productLine, 
customers.customerName, 
customers.country as customer_country, 
offices.country as office_country, 
products.buyPrice, 
products.priceEach, 
orderdetails.quantityOrdered, 
orderdetails.quantityOrdered * products.priceEach as sales_value,
orderdetails.quantityOrdered * buyPrice as cost_of_sales
from orders
inner join orderdetails
on orders.orderNumber = orderdetails.orderNumber
inner join customers
on orders.customerNumber = customers.customerNumber
inner join products
on orderdetails.productCode = products.productCode
inner join employees
on customers.salesRepEmployeeNumber = employees.employeeNumber
inner join offices
on employees.officeCode = offices.officeCode