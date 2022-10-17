{{
  config(
    materialized='table'
  )
}}

with users_source as (
  select * from {{ref ('stg_postgres__users')}}
)

, sessions_source as (
  select * from {{ref('int_sessions_agg')}}
)

select
    s.session_id
  , s.user_id
  , u.first_name
  , u.last_name
  , u.email
  , s.total_page_views
  , s.total_add_to_carts
  , s.total_checkouts
  , s.total_packages_shipped
  , s.total_events
from sessions_source s
left join users_source u on s.user_id = u.user_id