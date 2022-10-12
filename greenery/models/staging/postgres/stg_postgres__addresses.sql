{{
  config(
    materialized='view'
  )
}}

with addresses_source as (
    select * from {{ source('postgres', 'addresses') }}
)

select 
      address_id
    , address
    , zipcode
    , state
    , country
from addresses_source