{{ config(materialized='table') }}

with
    bom as (
         
select 
    bom."billofmaterialsid" as bill_of_materials_id,     -- ID da lista de materiais
    bom."productassemblyid" as product_assembly_id,      -- ID do produto montado
    bom."componentid" as component_id,                    -- ID do componente
    cast(bom."startdate" as date) as start_date,                        -- Data de início
    cast(bom."enddate" as date) as end_date,                            -- Data de término
    bom."unitmeasurecode" as unit_measure_code,           -- Código da unidade de medida
    bom."bomlevel" as bom_level,                          -- Nível da lista de materiais
    bom."perassemblyqty" as per_assembly_qty,             -- Quantidade por montagem
    cast(bom."modifieddate" as date) as modified_date                   -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'billofmaterials') }} as bom
-- Tabela que armazena as listas de materiais para produtos montados.

)
select *
from bom