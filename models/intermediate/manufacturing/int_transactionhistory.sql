{{ config(materialized='table') }}
with
    th as (
        select *
        from {{ ref('stg_transactionhistory') }}
    )
    , joined as (
        select 
        th.transaction_id,
        th.product_id,
        th.reference_order_id,
        th.reference_order_line_id,
        th.transaction_date,
        th.transaction_type,
        th.quantity,
        th.actual_cost
        from  th
        ) ,
        metrics as (  
        select * ,
        count(transaction_id) as total_transactions,
        sum(actual_cost) as total_cost,
        avg(actual_cost) as average_cost,  
        sum(quantity) as total_quantity,
        sum(actual_cost) / sum(quantity) as average_cost_per_product,
        count(reference_order_id) as total_transactions_order         
        from joined
        group by all
        )select * from metrics