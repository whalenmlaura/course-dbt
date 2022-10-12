{{
  config(
    materialized='view'
  )
}}

with order_items_source as (
    select * from {{ source('postgres', 'order_items') }}
)

SELECT 
      order_id
    , product_id
    , quantity
FROM order_items_source