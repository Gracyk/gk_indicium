
{{ config(materialized='table') }}

with
    pm as (
         
select 
    pm.productmodelid as product_model_id,         -- ID do modelo de produto
    pm.productdescriptionid as product_description_id, -- ID da descrição do produto
    pm.cultureid as culture_id,                    -- ID da cultura associada
    cast(pm.modifieddate as date) as modified_date               -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'productmodelproductdescriptionculture') }} as pm
-- Tabela que armazena as descrições de produtos associadas a diferentes culturas.

)
select *
from pm