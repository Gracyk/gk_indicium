{{ config(materialized='table') }}

with
    tha as (
         
select 
    tha.transactionid as transaction_id,              -- ID da transação
    tha.productid as product_id,                      -- ID do produto
    tha.referenceorderid as reference_order_id,      -- ID do pedido de referência
    tha.referenceorderlineid as reference_order_line_id, -- ID da linha do pedido de referência
    cast(tha.transactiondate as date) as transaction_date,  -- Data da transação
    tha.transactiontype as transaction_type,          -- Tipo de transação
    tha.quantity as quantity,                         -- Quantidade
    tha.actualcost as actual_cost,                    -- Custo real
    cast(tha.modifieddate as date) as modified_date   -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'transactionhistoryarchive') }} as tha
-- Tabela de histórico de transações arquivadas.

)
select *
from tha