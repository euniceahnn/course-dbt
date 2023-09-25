
{{
  config(
    materialized='table'
  )
}}

SELECT
  o.order_id,
  o.user_id,
  o.promo_id,
  o.address_id,
  o.created_at,
  o.order_cost,
  o.shipping_cost,
  o.order_total,
  o.tracking_id,
  o.shipping_service,
  o.estimated_delivery_at,
  o.delivered_at,
  o.status as order_status,
  pc.discount as promo_code_discount,
  oi.total_order_items
FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('stg_promos') }} pc
  ON o.promo_id = pc.promo_id
LEFT JOIN {{ ref('stg_users') }} u
  ON o.user_id = u.user_id
LEFT JOIN {{ ref('int_order_items') }} oi
  ON o.order_id = u.user_id
