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
    , name
    , price
    , inventory
FROM products_source


