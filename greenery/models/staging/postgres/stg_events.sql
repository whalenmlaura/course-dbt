{{
  config(
    materialized='view'
  )
}}

with events_source as (
    select * from {{ source('postgres', 'events') }}
)

SELECT 
      event_id
    , session_id
    , user_id
    , page_url
    , created_at
    , event_type
    , order_id
    , product_id
FROM events_source