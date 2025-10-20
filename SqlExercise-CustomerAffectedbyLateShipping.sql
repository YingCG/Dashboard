-- we have discoverd that shipping is delayed due to the weather, and it's possible they will take up to 3 days to arrive.
-- Please provide  a list of affected orders


-- to add 3 days to shipped day
-- select *, date_add(shippedDate, interval 3 day) as latest_arrival from orders

-- to create a flag when the latest arrival is later then require data
select *, 
date_add(shippedDate, interval 3 day) as latest_arrival,
case when date_add(shippedDate, interval 3 day) > requiredDate then 1 else 0 end as late_flag
from orders
where
(case when date_add(shippedDate, interval 3 day) > requiredDate then 1 else 0 end) =1