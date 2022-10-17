{{
  config(
    materialized='table'
  )
}}

with order_items as (
  select * from {{ref ('stg_postgres__order_items')}}
)

select
    product_id
  , count(distinct(order_id)) as num_orders
  , sum(quantity) as total_quantity_ordered
from order_items
group by 1