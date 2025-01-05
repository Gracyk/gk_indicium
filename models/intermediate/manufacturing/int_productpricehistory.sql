{{ config(materialized='table') }}
with
    plph as (
        select *
        from {{ ref('stg_productlistpricehistory') }}
    )
    , joined as (
        select 
        plph.product_id,
        plph.start_date,
        plph.end_date,
        plph.list_price
        from  plph
        ) ,
        metrics as
        (            
        select * ,
        count(list_price) as number_price_entries,
        avg(list_price) as average_price,
        sum(list_price) as total_price,
        max(list_price) - min(list_price) as price_range,
        count(distinct start_date) as price_change_count
        from joined
        group by all
        )
        select * from metrics