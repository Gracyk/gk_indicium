
{{ config(materialized='table') }}

with
    pmi as (
        
select 
    pmi.productmodelid as product_model_id,             -- ID do modelo do produto
    pmi.illustrationid as illustration_id,               -- ID da ilustração associada ao modelo
    cast(pmi.modifieddate as date) as modified_date          -- Data da última modificação
from 
   {{ source('raw_adventure_works', 'productmodelillustration') }} as pmi
    -- Tabela que contém informações sobre as ilustrações associadas aos modelos de produtos no sistema AdventureWorks.

)
select *
from pmi