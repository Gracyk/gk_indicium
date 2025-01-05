
{{ config(materialized='table') }}

with
    pm as (

select 
    pm.productmodelid as product_model_id,                -- ID do modelo do produto
    pm.name as product_model_name,                         -- Nome do modelo do produto
    pm.catalogdescription as catalog_description,         -- Descrição do catálogo do produto
    pm.instructions as instructions,                       -- Instruções de uso ou fabricação do produto
    pm.rowguid as row_guid,                                -- Identificador único da linha
    cast(pm.modifieddate as date) as modified_date         -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'productmodel') }} as pm
-- Tabela que contém informações sobre os modelos de produtos no sistema AdventureWorks.


)
select *
from pm