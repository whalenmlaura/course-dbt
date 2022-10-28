{{
  config(
    materialized='table'
  )
}}

with orders_source as (
  select * from {{ref ('stg_postgres__orders')}}
)

select 
    user_id
  , order_id
  , count(distinct order_id) as num_orders
  , sum(order_cost) as order_cost_without_shipping
  , sum(shipping_cost) as shipping_cost
  , sum(order_total) as total_order_cost
  , sum(case when promo_id is not null then 1 else 0 end) as total_promo_orders
  , min(created_at) as oldest_order
  , max(created_at) as newest_order
from orders_source
group by 1,2
