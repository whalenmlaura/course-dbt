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
select * from dev_db.dbt_laura.snapshot_orders 
where dbt_valid_to is not null
```

Order IDs that have changed:
* 914b8929-e04a-40f8-86ee-357f2be3a2a2
* 05202733-0e17-4726-97c2-0520c024ab85
* 939767ac-357a-4bec-91f8-a7b25edd46c9

### Dag image

![DAG](https://user-images.githubusercontent.com/111754475/195904300-fb08bd91-ed52-4185-bed8-88bf14ae33a9.PNG)

