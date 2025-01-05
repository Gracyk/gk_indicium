{{ config(materialized='table') }}

with
    th as (
         
select 
    th.transactionid as transaction_id,                -- ID da transação
    th.productid as product_id,                        -- ID do produto
    th.referenceorderid as reference_order_id,        -- ID do pedido de referência
    th.referenceorderlineid as reference_order_line_id, -- ID da linha do pedido de referência
    cast(th.transactiondate as date) as transaction_date,            -- Data da transação
    th.transactiontype as transaction_type,            -- Tipo de transação
    th.quantity as quantity,                          -- Quantidade
    th.actualcost as actual_cost,                      -- Custo real
    cast(th.modifieddate as date) as modified_date    -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'transactionhistory') }} as th
    -- Tabela que armazena o histórico de transações de produtos.
    )
    
select *
from th