{{
  config(
    materialized='table'
  )
}}

SELECT
order_id,
sum(quantity) as total_order_items
FROM {{ ref('stg_order_items') }} oi
GROUP BY 1