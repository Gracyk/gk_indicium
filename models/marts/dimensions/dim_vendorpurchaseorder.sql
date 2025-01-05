{{ config(materialized='table') }}

with
   v as (
        select *
        from {{ ref('int_vendorpurchaseorder') }}
   ) select * from v