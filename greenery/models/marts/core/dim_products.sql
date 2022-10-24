{{
  config(
    materialized='table'
  )
}}

with products_source as (
  select * from {{ref ('int_order_items_product_agg')}}
),

events_source as (
  select * from {{ref ('stg_postgres__events')}}
)

select 
    distinct(p.product_id) as product_id
  , p.product_name
  , p.inventory
  , p.price
  , count(distinct(p.order_id)) as total_num_orders
  , sum(p.quantity) as total_quantity_ordered
  , sum(p.quantity * p.price) as total_revenue
  , count(distinct case when e.event_type = 'page_view' then e.session_id else null end) as poduct_viewed_sessions
  , count(distinct case when e.event_type = 'add_to_cart' then e.session_id else null end) as poduct_added_to_cart_sessions
from products_source p
left join events_source e on p.product_id = e.product_id
group by 1,2,3,4
order by 2 asc

