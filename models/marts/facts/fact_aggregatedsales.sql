{{ config(materialized='table') }}

with
    s as (
        select *
        from {{ ref('int_sales') }}
    )
    select * from s