{{
  config(
    materialized='table'
  )
}}

with events_unpacked as (
    select * from {{ ref('int_events_unpacked') }}
),

products as (
    select * from {{ ref('stg_postgres__products') }}
)

select  e.product_guid_coalesce as product_guid
        , p.product_name
        , count(distinct e.session_id) as sessions
        , {{ agg_event_type('page_view') }} as page_views
        , {{ agg_event_type('add_to_cart')}} as adds_to_cart
        , {{ agg_event_type('checkout') }} as checkouts
        , {{ agg_event_type('package_shipped') }} as packages_shipped
from events_unpacked e
left join products p on e.product_guid_coalesce = p.product_id
group by 1,2