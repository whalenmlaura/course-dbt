{{
  config(
    materialized='table'
  )
}}

with events_source as (
  select * from {{ref ('stg_postgres__events')}}
)

, create_metrics as (
  select
      *
    , case when lower(event_type) = 'checkout' then 1 else 0 end as checkouts
    , case when lower(event_type) = 'package_shipped' then 1 else 0 end as package_shippeds
    , case when lower(event_type) = 'add_to_cart' then 1 else 0 end as add_to_carts
    , case when lower(event_type) = 'page_view' then 1 else 0 end as page_views
  from events_source
)

select
      created_at
    , session_id
    , event_id
    , user_id
    , page_url
    , event_type
    , order_id
    , product_id
    , sum(checkouts) as total_checkouts
    , sum(package_shippeds) as total_packages_shipped
    , sum(add_to_carts) as total_add_to_carts
    , sum(page_views) as total_page_views
    , sum(checkouts + package_shippeds + add_to_carts + page_views) as total_events
from create_metrics
group by 1,2,3,4,5,6,7,8