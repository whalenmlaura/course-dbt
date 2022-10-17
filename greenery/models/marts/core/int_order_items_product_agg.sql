{{
  config(
    materialized='table'
  )
}}

with order_items_source as (
    select * from {{ref ('stg_postgres__order_items')}}
)

, products_source as (
    select * from {{ref ('stg_postgres__products')}}
)

, join_tables as (
    select
        o.order_id
      , o.product_id
      , o.quantity
      , p.product_id as p_product_id
      , p.product_name
      , p.price
      , p.inventory
    from order_items_source o 
    left join products_source p on o.product_id = p.product_id
)

select
    order_id
  , product_id
  , product_name
  , quantity
  , inventory
  , price
from join_tables