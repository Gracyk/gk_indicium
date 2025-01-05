{{ config(materialized='table') }}

with
    sr as (
        select * 
        from {{ref ('int_salesperson')}}
    )
     select * from sr