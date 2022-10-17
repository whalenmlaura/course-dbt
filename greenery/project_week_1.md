## Week 1

### How many users do we have? 

```
select 
    count(distinct(user_id)) as num_users 
from dev_db.dbt_laura.stg_postgres__users
```

There are 130 users

### On average, how many orders do we receive per hour?

```
with orders_per_hour as (
    select
          hour(created_at) as created_at_hour
        , count(distinct(order_id)) as num_orders
    from dev_db.dbt_laura.stg_postgres__orders
    group by hour(created_at)
    order by hour(created_at)
)

select
    round(avg(num_orders)) as avg_orders_per_hour
from orders_per_hour
```

On average, there are 15 orders per hour

### On average, how long does an order take from being placed to being delivered?

```
select
    round(avg(datediff(day, created_at, delivered_at))) as avg_days_to_deliver
from dev_db.dbt_laura.stg_postgres__orders
where delivered_at is not null
```

On average, it takes 4 days for an order to be delivered after it's placed

### How many users have only made one purchase? Two purchases? Three+ purchases?

```
with user_orders as (
    select
          user_id
        , count(distinct(order_id)) as num_orders
    from dev_db.dbt_laura.stg_postgres__orders
    group by user_id
)

select
      sum(case when num_orders = 1 then 1 else 0 end) as one_order
    , sum(case when num_orders = 2 then 1 else 0 end) as two_orders
    , sum(case when num_orders >= 3 then 1 else 0 end) as three_plus_orders
from user_orders
```

* 25 users have made one purchase
* 28 users have made two purchases
* 71 users have made three or more purchases

### On average, how many unique sessions do we have per hour?

```
with sessions_per_hour as (
    select
          hour(created_at) as created_at_hour
        , count(distinct(session_id)) as num_sessions
    from dev_db.dbt_laura.stg_postgres__events
    group by hour(created_at)
    order by hour(created_at)
)

select
    round(avg(num_sessions)) as avg_sessions_per_hour
from sessions_per_hour
```

On average, there are 39 unique sessions per hour


[Link to Snowflake queries](https://app.snowflake.com/us-east-1/ryb00700/w29Gb55pEkhg#query)