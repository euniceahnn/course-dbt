How many users do we have? 130 
`select count(distinct user_id) from dev_db.dbt_eunzzygmailcom.stg_users`

On average, how many orders do we receive per hour?
~7-8 orders per hour / specifically 7.520833

with orders_per_hour as 

(select 
date_trunc('hour',created_at) created_at_hour,
count(distinct order_id) orders 
from dev_db.dbt_eunzzygmailcom.stg_orders
group by 1)

select
avg(orders)
from orders_per_hour 

On average, how long does an order take from being placed to being delivered? 93.4 hours
with time_to_delivery as 
(select 
order_id,
datediff('hours',created_at,delivered_at) as hrs_to_delivery
from dev_db.dbt_eunzzygmailcom.stg_orders
where status = 'delivered'
)

select
avg(hrs_to_delivery)
from time_to_delivery 

How many users have only made one purchase? Two purchases? Three+ purchases? 
Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

25 / 28 / 34

with orders_per_user as
(select 
user_id,
count(distinct order_id) orders 
from dev_db.dbt_eunzzygmailcom.stg_orders
group by 1
)

select
orders,
count(distinct user_id)
from orders_per_user
group by 1 
order by 1



On average, how many unique sessions do we have per hour? 16.327586
with sessions_per_hour as
(select 
date_trunc('hour',created_at) session_hour,
count(distinct session_id) sessions
from dev_db.dbt_eunzzygmailcom.stg_events
group by 1
)

select
avg(sessions) as avg_sessions
from sessions_per_hour 
