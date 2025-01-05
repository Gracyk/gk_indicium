{{ config(materialized='table') }}
with
    so as (
        select *
        from {{ ref('int_specialoffer') }}
    )
    select * from so