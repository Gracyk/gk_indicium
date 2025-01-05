{{ config(materialized='table') }}
with
    sohsr as (
        select *
        from {{ ref('stg_salesorderheadersalesreason') }}
    )

    , sr as (
        select *
        from {{ ref('stg_salesreason') }}
    )
    , joined as (
        select sohsr.sales_order_id,
        sohsr.sales_reason_id,
        sr.name as name_sales_reason,
        sr.reason_type 
        from sohsr 
        left join sr
         on sohsr.sales_reason_id = sr.sales_reason_id
    )
    select * from joined