
{{ config(materialized='table') }}

with
    s as (
         -- seleciona dados de loja  (store) 
select 
    s.businessentityid as business_entity_id,   -- Identificador único de loja
    s.name as name_store,           -- Nome da loja
    s.salespersonid as sales_person_id,       -- Identificador vendedor
    s.demographics as demographics,    -- demografia
    s.rowguid as rowguid,      -- codigo linha
    cast(s.modifieddate as date) as modified_date      -- Data da última modificação no registro
from 
    {{ source('raw_adventure_works', 'store') }} as s
)
select *
from s