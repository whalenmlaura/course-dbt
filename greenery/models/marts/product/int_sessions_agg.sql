{{
  config(
    materialized='table'
  )
}}

{%- 
  set event_types = dbt_utils.get_column_values(
      table = ref('stg_postgres__events')
    , column = 'event_type'
  )
-%}

select
    created_at
  , session_id
  , event_id
  , user_id
  , page_url
  , event_type
  , order_id
  , product_id
  {%- for event_type in event_types %}
  , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as total_{{ event_type }}
  {%- endfor %}
from {{ref ('stg_postgres__events')}}
group by 1,2,3,4,5,6,7,8