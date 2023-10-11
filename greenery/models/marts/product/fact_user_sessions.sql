with session_events_agg as (
    select * from {{ ref('int_session_events') }}
)

, users as (
    select * from {{ ref('stg_users') }}
)

, addresses as (
    select * from {{ ref('stg_addresses') }}
)

, order_items as (
    select * from {{ ref('stg_order_items') }}
)

select
  s.session_id,
  coalesce(s.product_id, oi.product_id) as product_id,
  s.user_id,
  u.first_name,
  u.last_name,
  u.email,
  a.address_id,
  a.address,
  a.zipcode,
  a.state,
  a.country,
  s.page_views,
  s.add_to_carts,
  s.checkouts,
  s.package_shippeds,
  s.first_session_event_at_utc as first_session_event,
  s.last_session_event_at_utc as last_session_event,
  datediff('minute',first_session_event,last_session_event) as session_length_minutes
from session_events_agg s 
left join users u 
    on s.user_id = u.user_id
left join addresses a 
    on u.address_id = a.address_id
left join order_items oi 
    on s.order_id = oi.order_id     