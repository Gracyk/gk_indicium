{{ config(materialized='table') }}

with
    sr as (
        select *
        from {{ ref('int_salesreason') }}
    )
        select * from sr