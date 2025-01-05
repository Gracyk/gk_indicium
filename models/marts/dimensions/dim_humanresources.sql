{{ config(materialized='table') }}

with
   h as (
        select *
        from {{ ref('int_humanresources') }}
   ) select * from h