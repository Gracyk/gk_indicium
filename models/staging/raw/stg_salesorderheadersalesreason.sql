{{ config(materialized='table') }}

with
    sohs as (
         
select 
    sohs.salesorderid as sales_order_id,        -- ID do pedido de venda
    sohs.salesreasonid as sales_reason_id,      -- ID do motivo da venda
    cast(sohs.modifieddate as date) as modified_date -- Data da última modificação
from     
   {{ source('raw_adventure_works', 'salesorderheadersalesreason') }} as sohs
-- Tabela de associação entre o pedido de venda e os motivos de venda.


)
select *
from sohs