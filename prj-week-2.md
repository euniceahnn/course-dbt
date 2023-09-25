What is our user repeat rate?

79.8%

`with orders as 
(select
user_id,
count(distinct order_id) orders 
FROM DEV_DB.DBT_EUNZZYGMAILCOM.STG_ORDERS
group by 1)

select
count(distinct case when orders > 1 then user_id else null end) users_multi_purchase,
count(distinct user_id) as total_users,
users_multi_purchase/total_users
from orders`

What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Users likely to purchase again: High CSAT scores, frequent visits to website/app, purchase behavior - how frequently, time between purchases
Not like to purchase again: Low CSAT scores, low website/app engagement, long time between 1st purchase, unsubscribe to email 
Feature: user engagement to company 

