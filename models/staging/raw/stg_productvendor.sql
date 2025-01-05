
{{ config(materialized='table') }}

with
    pv as (

select 
    pv.productid as product_id,                -- ID do produto
    pv.businessentityid as business_entity_id, -- ID da entidade de negócios (fornecedor)
    pv.averageleadtime as average_lead_time,   -- Tempo médio de entrega
    pv.standardprice as standard_price,        -- Preço padrão do produto
    pv.lastreceiptcost as last_receipt_cost,   -- Custo da última recepção
    cast(pv.lastreceiptdate as date) as last_receipt_date,   -- Data da última recepção
    pv.minorderqty as min_order_qty,           -- Quantidade mínima de pedido
    pv.maxorderqty as max_order_qty,           -- Quantidade máxima de pedido
    pv.onorderqty as on_order_qty,             -- Quantidade em pedido
    pv.unitmeasurecode as unit_measure_code,   -- Código da unidade de medida
    cast(pv.modifieddate as date) as modified_date   -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'productvendor') }} as pv
-- Tabela que contém os dados dos fornecedores de produtos no sistema AdventureWorks.
)
select *
from pv