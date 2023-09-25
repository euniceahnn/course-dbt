{{
  config(
    materialized='view'
  )
}}

SELECT 
  product_id,
  name as product_name,
  price as product_price,
  inventory
FROM {{ source('postgres', 'products') }}