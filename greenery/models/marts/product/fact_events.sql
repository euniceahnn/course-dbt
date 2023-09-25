{{
  config(
    materialized='table'
  )
}}

SELECT
  event_id,
  session_id,
  user_id,
  page_url,
  created_at,
  event_type,
  order_id,
  order_cost,
  shipping_cost,
  order_total,
  product_id,
  product_name,
  product_price
FROM {{ ref('int_events') }} e
