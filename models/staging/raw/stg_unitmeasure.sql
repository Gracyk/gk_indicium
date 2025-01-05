
{{ config(materialized='table') }}

with
    um as (
         -- seleciona dados de Cartão de crédito  (credit card) 
select 
    um.unitmeasurecode as unit_measure_code,  -- Código da unidade de medida
    um.name as name,                          -- Nome da unidade de medida
    cast(um.modifieddate as date) as modified_date   -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'unitmeasure') }} as um
-- Tabela que contém informações sobre as unidades de medida no sistema AdventureWorks. 
)
select *
from um