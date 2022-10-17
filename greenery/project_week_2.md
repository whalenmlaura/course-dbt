## Week 2

### What is our user repeat rate?

```
with user_order_count as (
    select
          user_id
        , count(distinct(order_id)) as num_orders
    from dev_db.dbt_laura.stg_postgres__orders
    group by 1
)

select
      count(distinct(user_id)) as num_users
    , sum(case when num_orders >= 2 then 1 else 0 end) as repeat_users
    , div0(repeat_users, num_users)*100 as repeat_rate
from user_order_count
```

The user repeat rate is 79.84%

### Which orders changed from week 1 to week 2? 

```
select
     order_id
   , count(distinct(order_id)) as num_orders
from dev_db.dbt_laura.snapshot_orders
group by 1
having num_orders > 1
```

No new orders this week? I think this might be because I'm submitting the project late

### Dag image

![DAG](https://user-images.githubusercontent.com/111754475/195904300-fb08bd91-ed52-4185-bed8-88bf14ae33a9.PNG)

