{{
  config(
    materialized='view'
  )
}}

with products_source as (
    select * from {{ source('postgres', 'products') }}
)

SELECT 
      product_id
    , name as product_name
    , price
    , inventory
FROM products_source


