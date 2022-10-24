## Week 3

### What is our overall conversion rate?

```

```

The user repeat rate is 79.84%

### What is our conversion rate by product?

```

```

The user repeat rate is 79.84%

### Which orders changed from week 2 to week 3? 

```
select * from dev_db.dbt_laura.snapshot_orders 
where dbt_valid_to is not null
```

Order IDs that have changed:
* 914b8929-e04a-40f8-86ee-357f2be3a2a2
* 05202733-0e17-4726-97c2-0520c024ab85
* 939767ac-357a-4bec-91f8-a7b25edd46c9

### Dag image

![DAG](https://github.com/whalenmlaura/course-dbt/blob/main/greenery/laura_dag_week_3.png)

