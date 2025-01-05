{{ config(materialized='table') }}

with
    p as (
        select *
        from {{ ref('int_product') }}
     ),
       
    tha as (
        select *
        from {{ ref('int_transactionhistoryarchive') }}
     ),
     joined as (  

     select 
        p.product_id,
        p.product_name,
        p.product_number,
        
        tha.reference_order_id as reference_order_id_tha,
        tha.reference_order_line_id as reference_order_line_id_tha,
        tha.transaction_type as transaction_type_tha,
        tha.quantity as quantity_tha,
        tha.actual_cost as actual_cost_tha,
        tha.num_products as num_products_tha,
        tha.number_transaction_type as number_transaction_type_tha,
        tha.avg_actual_cost as avg_actual_cost_tha,
        tha.number_actual_cost as number_actual_cost_avg,
        tha.total_actual_cost as total_actual_cost_tha,
        tha.max_actual_cost as max_actual_cost_tha,
        tha.min_actual_cost as min_actual_cost_tha
        
     from p      
     left join tha on p.product_id = tha.product_id
  
     ) 
     select * from joined