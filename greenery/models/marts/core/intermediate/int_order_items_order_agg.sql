{{
  config(
    materialized='table'
  )
}}

with order_items as (
  select * from {{ref ('stg_postgres__order_items')}}
)

select
    distinct(order_id) as order_id
  , count(distinct(product_id)) as num_products
  , sum(quantity) as total_quantity
from order_items
group by 1