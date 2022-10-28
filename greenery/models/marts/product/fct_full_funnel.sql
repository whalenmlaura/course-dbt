{{
  config(
    materialized='table'
  )
}}

with products_source as (
  select * from {{ref ('stg_postgres__products')}}
)

, user_orders_source as (
  select * from {{ref('int_user_orders')}}
)

, events_source as (
  select * from {{ref('int_events_unpacked')}}
)

, field_selection as (
  select
      e.created_at
    , e.country
    , e.state
    , e.zipcode
    , e.session_id
    , e.product_id_coalesce as product_id
    , p.product_name
    , e.order_id
    , u.total_order_cost
    , e.event_type
  from events_source e
  left join products_source p on e.product_id_coalesce = p.product_id
  left join user_orders_source u on e.order_id = u.order_id
)

, create_metrics as (
  select
      cast({{ date_trunc('day', 'created_at') }} as date) as date
    , cast({{ date_trunc('week', 'created_at') }} as date) as week
    , cast({{ date_trunc('month', 'created_at') }} as date) as month
    , country
    , state
    , zipcode
    , product_name
    , count(distinct(session_id)) as total_sessions
    , {{ agg_event_type('page_view') }} as page_views
    , {{ agg_event_type('add_to_cart')}} as adds_to_cart
    , {{ agg_event_type('checkout') }} as checkouts
    , {{ agg_event_type('package_shipped') }} as packages_shipped
  from field_selection
  group by 1,2,3,4,5,6,7
)

select
    date
  , week
  , month
  , country
  , state
  , product_name
  , sum(total_sessions) as total_sessions
  , sum(page_views) as total_page_views
  , sum(adds_to_cart) as total_add_to_carts
  , sum(checkouts) as total_checkouts
  -- , nullif(sum(page_views)/sum(total_sessions),0) as session_to_page_view_cvr
  -- , nullif(sum(adds_to_cart)/sum(page_views),0) as page_views_to_add_to_cart_cvr
  -- , nullif(sum(checkouts)/sum(adds_to_cart),0) as add_to_cart_to_checkout_cvr
from create_metrics
group by 1,2,3,4,5,6

