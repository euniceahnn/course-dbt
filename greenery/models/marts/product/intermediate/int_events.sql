{{
  config(
    materialized='table'
  )
}}
dbt 
SELECT
  e.event_id,
  e.session_id,
  e.user_id,
  e.page_url,
  e.created_at,
  e.event_type,
--Order information (only populates for checkout and package shipped)
  e.order_id,
  o.order_cost,
  o.shipping_cost,
  o.order_total,
--Product information (only populates for add to cart and page view)
  e.product_id,
  p.product_name,
  p.product_price
FROM {{ ref('stg_events') }} e
LEFT JOIN {{ ref('stg_orders') }} o
  ON e.order_id = o.order_id 
LEFT JOIN {{ ref('stg_products') }} p
  ON e.product_id = p.product_id