{{ config(materialized='table') }}

with
   c as (
        select *
        from {{ ref('int_customer') }}
   ) select * from c