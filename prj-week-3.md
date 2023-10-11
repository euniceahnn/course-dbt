What is our overall conversion rate?
# of unique sessions with a purchase event / total number of unique sessions
-- 62.46%
select
count(distinct case when checkouts > 0 then session_id end) as sessions_with_checkouts,
count(distinct session_id) as sessions,
sessions_with_checkouts/sessions as cvr 
from DEV_DB.DBT_EUNZZYGMAILCOM.FACT_USER_SESSIONS

What is our conversion rate by product?

select
product_name,
count(distinct case when checkouts > 0 then session_id end) as sessions_with_checkouts,
count(distinct session_id) as sessions,
sessions_with_checkouts/sessions as cvr 
from DEV_DB.DBT_EUNZZYGMAILCOM.FACT_USER_SESSIONS f 
left join DEV_DB.DBT_EUNZZYGMAILCOM.dim_products p on f.product_id = p.product_id 
group by 1;

