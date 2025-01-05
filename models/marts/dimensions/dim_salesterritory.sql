{{ config(materialized='table') }}

with
    st as (
        select * 
        from {{ref ('int_salesterritory')}}

    ) select * from st