{{ config(materialized='table') }}

with
    p as (
        select *
        from {{ ref('int_product') }}
    )
     select * from p