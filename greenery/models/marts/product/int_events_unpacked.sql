{{
  config(
    materialized='table'
  )
}}

with unpack as (
    select  
         coalesce(poi.product_id, pe.product_id) product_id_coalesce
        , pe.event_id --note that the event guid is no longer unique, since it can be the same if >1 products were checked out or shipped in a single event
        , pe.session_id
        , pe.user_id
        , pe.page_url
        , pe.created_at
        , pe.event_type
        , pe.order_id
    from {{ ref('stg_postgres__order_items') }} poi
    full outer join {{ ref('stg_postgres__events') }} pe
        on poi.order_id = pe.order_id
),

address_source as (
  select * from {{ref ('stg_postgres__addresses')}}
),

user_source as (  
  select * from {{ref ('stg_postgres__users')}}
),

user_addresses as (
  select
      u.user_id
    , u.address_id
    , a.country
    , a.state
    , cast(a.zipcode as string) as zipcode
  from user_source u
  left join address_source a on u.address_id = a.address_id
)

select 
    {{ dbt_utils.surrogate_key(['product_id_coalesce', 'event_id']) }} as surrogate_key
    , u.product_id_coalesce
    , u.event_id 
    , u.session_id
    , u.order_id
    , u.user_id
    , u.page_url
    , u.created_at
    , u.event_type
    , a.country
    , a.state
    , a.zipcode
from unpack u
left join user_addresses a on u.user_id = a.user_id