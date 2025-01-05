{{ config(materialized='table') }}
with
    tha as (
        select *
        from {{ ref('stg_transactionhistoryarchive') }}
    )
    , joined as (
        select 
        tha.transaction_id,
        tha.product_id,
        tha.reference_order_id,
        tha.reference_order_line_id,
        tha.transaction_date,
        tha.transaction_type,
        tha.quantity,
        tha.actual_cost,
        from  tha
        ),
        metrics as
        (select *,
        count(distinct product_id) as num_products, 
        count(transaction_type) as number_transaction_type,
        avg(actual_cost) as avg_actual_cost,   
        count(actual_cost) as number_actual_cost, 
        sum(actual_cost) as total_actual_cost,
        max(actual_cost) as max_actual_cost,   
        min(actual_cost) as min_actual_cost  
        from joined
        group by all
        ) select * from metrics