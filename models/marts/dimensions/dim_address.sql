{{ config(materialized='table') }}

with
   a as (
        select * 
        from {{ref ('int_address')}}
    ) 
    select * from a