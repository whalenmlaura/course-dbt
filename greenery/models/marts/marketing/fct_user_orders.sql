{{
  config(
    materialized='table'
  )
}}

with users_source as (
  select * from {{ref ('stg_postgres__users')}}
)

, addresses_source as (
  select * from {{ref ('stg_postgres__addresses')}}
)

, user_orders as (
    select * from {{ref('int_user_orders')}}
)

, join_tables as (
    select
        u.user_id
      , u.first_name
      , u.last_name
      , u.email
      , u.phone_number
      , u.created_at
      , u.updated_at
      , u.address_id
      , a.address_id as a_address_id
      , a.address
      , a.zipcode
      , a.state
      , a.country
      , uo.user_id as uo_user_id
      , uo.num_orders
      , uo.order_cost_without_shipping
      , uo.shipping_cost
      , uo.total_order_cost
      , uo.total_promo_orders
      , uo.oldest_order
      , uo.newest_order
    from users_source u
    left join addresses_source a on u.address_id = a.address_id
    left join user_orders uo on u.user_id = uo.user_id
)

select
    user_id
  , first_name
  , last_name
  , email
  , phone_number
  , created_at
  , updated_at
  , address_id
  , address
  , zipcode
  , state
  , country
  , num_orders
  , order_cost_without_shipping
  , shipping_cost
  , total_order_cost
  , total_promo_orders
  , oldest_order
  , newest_order
from join_tables