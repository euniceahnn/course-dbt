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
  product_id,
  product_name,
  product_price
FROM {{ ref('int_events') }} e
WHERE event_type = 'page_view'
