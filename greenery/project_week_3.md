## Week 3

### What is our overall conversion rate?

```
with purchase_sessions as (
    select
          count(distinct(session_id)) as unique_sessions
        , sum(case when total_checkout = 1 then 1 else 0 end) as checkout_sessions
    from dev_db.dbt_laura.fct_session_events
)

select
    div0(checkout_sessions, unique_sessions)*100 as conversion_rate
from purchase_sessions;
```

The conversion rate is 62.46%

### What is our conversion rate by product?

```
select
      product_name
    , div0(checkouts, sessions)*100 as conversion_rate
from dev_db.dbt_laura.int_product_events
order by 1 asc;
```

| Product Name                         |  Conversion Rate   |
|--------------------------------------|--------------------|
| Alocasia Polly                       | 41.2%              |
| Aloe Vera                            | 49.2%              |
| Angel Wings Begonia                  | 39.3%              |
| Arrow Head                           | 55.6%              |
| Bamboo                               | 53.7%              |
| Bird of Paradise                     | 45.0%              |
| Birds Nest Fern                      | 42.3%              |
| Boston Fern                          | 41.3%              |
| Cactus                               | 54.5%              |
| Calathea Makoyana                    | 50.9%              |
| Devil's Ivy                          | 48.9%              |
| Dragon Tree                          | 46.8%              |
| Ficus                                | 42.6%              |
| Fiddle Leaf Fig                      | 50.0%              |
| Jade Plant                           | 47.8%              |
| Majesty Palm                         | 49.2%              |
| Money Tree                           | 46.4%              |
| Monstera                             | 51.0%              |
| Orchid                               | 45.3%              |
| Peace Lily                           | 40.9%              |
| Philodendron                         | 48.4%              |
| Pilea Peperomioides                  | 47.5%              |
| Pink Anthurium                       | 49.9%              |
| Ponytail Palm                        | 40.0%              |
| Pothos                               | 34.4%              |
| Rubber Plant                         | 51.9%              |
| Snake Plant                          | 39.7%              |
| Spider Plant                         | 47.5%              |
| String of Pearls                     | 60.9%              |
| ZZ Plant                             | 54.0%              |


### Which orders changed from week 2 to week 3? 

```
select * from dev_db.dbt_laura.snapshot_orders 
where dbt_valid_to is not null
```

Order IDs that have changed:
* 8385cfcd-2b3f-443a-a676-9756f7eb5404
* e24985f3-2fb3-456e-a1aa-aaf88f490d70
* 5741e351-3124-4de7-9dff-01a448e7dfd4
* 914b8929-e04a-40f8-86ee-357f2be3a2a2
* 05202733-0e17-4726-97c2-0520c024ab85
* 939767ac-357a-4bec-91f8-a7b25edd46c9

### Dag image

![DAG](https://github.com/whalenmlaura/course-dbt/blob/main/greenery/laura_dag_week_3.png)

