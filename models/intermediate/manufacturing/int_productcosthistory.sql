{{ config(materialized='table') }}
with
    pch as (
        select *
        from {{ ref('stg_productcosthistory') }}
    )
    , joined as (
        select 
        pch.product_id,
        pch.start_date,
        pch.end_date,
        pch.standard_cost
        from  pch
        ),
        metrics as
        (select *,
        count(distinct product_id) as num_products, 
        avg(standard_cost) as avg_standard_cost,   
        count(standard_cost) as total_cost_changes, 
        max(standard_cost) as max_standard_cost,   
        min(standard_cost) as min_standard_cost,  
        cast(avg(datediff('day', start_date, end_date)) as int) as duration_avg_days   
        from joined
        group by all
        ) select * from metrics