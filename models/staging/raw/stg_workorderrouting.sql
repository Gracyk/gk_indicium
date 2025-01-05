{{ config(materialized='table') }}

with
    wr as (
         
select 
    wr.workorderid as work_order_id,           -- ID da ordem de trabalho
    wr.productid as product_id,               -- ID do produto
    wr.operationsequence as operation_sequence, -- Sequência da operação
    wr.locationid as location_id,             -- ID da localização
    cast(wr.scheduledstartdate as date) as scheduled_start_date,  -- Data de início programada
    cast(wr.scheduledenddate as date) as scheduled_end_date,    -- Data de término programada
    cast(wr.actualstartdate as date) as actual_start_date,   -- Data de início real
    cast(wr.actualenddate as date) as actual_end_date,       -- Data de término real
    wr.actualresourcehrs as actual_resource_hours, -- Horas de recurso reais
    wr.plannedcost as planned_cost,           -- Custo planejado
    wr.actualcost as actual_cost,             -- Custo real
    cast(wr.modifieddate as date) as modified_date -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'workorderrouting') }} as wr
-- Tabela que armazena informações sobre o roteamento da ordem de trabalho.

)
select *
from wr