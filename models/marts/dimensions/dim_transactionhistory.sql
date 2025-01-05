{{ config(materialized='table') }}

with
    p as (
        select *
        from {{ ref('int_product') }}
     ),
       
    th as (
        select *
        from {{ ref('int_transactionhistory') }}
     ),
     joined as (  

     select 
        p.product_id,
        p.product_name,
        p.product_number,        
        th.reference_order_id,
        th.reference_order_line_id,
        th.transaction_type,
        th.quantity,
        th.actual_cost,
        th.total_transactions,
        th.total_cost,
        th.average_cost,
        th.total_quantity,
        th.average_cost_per_product,
        th.total_transactions_order,
        

     from p      
     left join th on p.product_id = th.product_id  
    
     ) 
     select * from joined