{{ config(materialized='table') }}
with
    sth as (
        select *
        from {{ ref('stg_salesterritoryhistory') }}
    )
    ,
       spqh as (
        select *
        from {{ ref('stg_salespersonquotahistory') }}
    )
    , joined as (
    select  
        sth.business_entity_id,
        sth.territory_id,
        sth.start_date,
        sth.end_date,
        spqh.quota_date,
        spqh.sales_quota
    from   sth 
    left join  spqh 
     on sth.business_entity_id=spqh.business_entity_id
    ),
    metrics as(
    select *,
    count(distinct business_entity_id) as num_records,
    avg(sales_quota) as avg_sales_quota,
    sum(sales_quota) as total_sales_quota,
    min(quota_date) as start_quota_date,
    max(quota_date) as end_quota_date,
    count(distinct business_entity_id) as num_salespersons_with_quota,
    avg(sales_quota) as avg_sales_quota_per_person,
    count(distinct quota_date) as active_quota_periods
    from joined
    group by all
    )   
    select * from metrics