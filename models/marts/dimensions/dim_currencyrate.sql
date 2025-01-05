{{ config(materialized='table') }}

with
    cr as (
        select *
        from {{ ref('int_currencyrate') }}
    )
     select * from cr