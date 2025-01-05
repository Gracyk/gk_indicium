
{{ config(materialized='table') }}

with
    ct as (
       
select 
    ct.contacttypeid as contact_type_id,  -- Identificador único do tipo de contato
    ct.name as name,                       -- Nome do tipo de contato
    cast(ct.modifieddate as date) as modified_date -- Data da última modificação no registro
from 
    {{ source('raw_adventure_works', 'contacttype') }} as ct
-- Tabela contendo os diferentes tipos de contato disponíveis no sistema.
)
select *
from ct