{{ config(materialized='table') }}

with  
     cc as (
        select *
        from {{ ref('int_creditcard') }}
        )
    select * from cc