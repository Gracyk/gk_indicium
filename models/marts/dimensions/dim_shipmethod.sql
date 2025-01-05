{{ config(materialized='table') }}
with
    sm as (
        select *
        from {{ ref('int_shipmethod') }}
    ) 
    select * from sm