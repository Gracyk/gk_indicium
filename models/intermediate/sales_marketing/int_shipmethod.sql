{{ config(materialized='table') }}
with
    sm as (
        select *
        from {{ ref('stg_shipmethod') }}
    )
    , joined as (
        select 
        ship_method_id,
        ship_method_name,
        ship_base,
        ship_rate
        from sm
        )   
    select * from joined