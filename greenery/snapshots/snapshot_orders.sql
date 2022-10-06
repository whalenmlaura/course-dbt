
{% snapshot snapshot_orders %}

{{
  config(
      target_database='dev_db'
    , target_schema='dbt_laura'
    , strategy='check'
    , unique_key='order_id'
    , check_cols=['status']
   )
}}

select * from {{ source('postgres','orders') }}

{% endsnapshot %}
