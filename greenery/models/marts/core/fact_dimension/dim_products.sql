{{
  config(
    materialized='table'
  )
}}

with products_source as (
  select * from {{ref ('int_order_items_product_spend_agg')}}
)

select 
    distinct(product_id) as product_id
  , product_name
  , inventory
  , price
  , count(distinct(order_id)) as total_num_orders
  , sum(quantity) as total_quantity_ordered
  , sum(quantity * price) as total_revenue
from products_source
group by 1,2,3,4
order by 2 asc