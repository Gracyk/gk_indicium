{{ config(materialized='table') }}

with
    wo as (
         
select 
    wo.workorderid as work_order_id,        -- ID da ordem de trabalho
    wo.productid as product_id,            -- ID do produto
    wo.orderqty as order_quantity,         -- Quantidade do pedido
    wo.scrappedqty as scrapped_quantity,   -- Quantidade descartada
    cast(wo.startdate as date) as start_date,            -- Data de início
    cast(wo.enddate as date) as end_date,                -- Data de término
    cast(wo.duedate as date) as due_date,                -- Data de vencimento
    wo.scrapreasonid as scrap_reason_id,   -- ID do motivo do descarte
    cast(wo.modifieddate as date) as modified_date       -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'workorder') }} as wo
-- Tabela que armazena informações sobre ordens de trabalho.

)
select *
from wo