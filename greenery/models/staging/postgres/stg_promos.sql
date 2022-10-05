{{
  config(
    materialized='view'
  )
}}

with promos_source as (
    select * from {{ source('postgres', 'promos') }}
)

SELECT 
      promo_id
    , discount
    , status
FROM promos_source


