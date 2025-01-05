
{{ config(materialized='table') }}

with
    be as (
        
select 
    be.businessentityid as business_entity_id,  -- Identificador único da entidade de negócios
    be.rowguid as row_guid,                      -- GUID único para identificar a linha
    cast(be.modifieddate as date) as modified_date -- Data da última modificação no registro
from 
    {{ source('raw_adventure_works', 'businessentity') }} as be
-- Tabela contendo as entidades de negócios registradas no sistema.
)
select *
from be