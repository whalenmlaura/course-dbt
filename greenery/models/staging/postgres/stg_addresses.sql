{{
  config(
    materialized='view'
  )
}}

with addresses_source as (
    select * from {{ source('postgres', 'addresses') }}
)

SELECT 
      address_id
    , address
    , zipcode
    , state
    , country
FROM addresses_source