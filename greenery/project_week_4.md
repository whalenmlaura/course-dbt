## Week 4

### Which orders changed from week 3 to week 4? 

```
select * from dev_db.dbt_laura.snapshot_orders 
where dbt_valid_to is not null
```

Order IDs that have changed:
* 8385cfcd-2b3f-443a-a676-9756f7eb5404
* e24985f3-2fb3-456e-a1aa-aaf88f490d70
* 5741e351-3124-4de7-9dff-01a448e7dfd4
* 38c516e8-b23a-493a-8a5c-bf7b2b9ea995
* d1020671-7cdf-493c-b008-c48535415611
* aafb9fbd-56e1-4dcc-b6b2-a3fd91381bb6
* 914b8929-e04a-40f8-86ee-357f2be3a2a2
* 05202733-0e17-4726-97c2-0520c024ab85
* 939767ac-357a-4bec-91f8-a7b25edd46c9