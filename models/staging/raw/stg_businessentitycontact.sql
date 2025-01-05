
{{ config(materialized='table') }}

with
    cc as (
        
select 
    bc.businessentityid as business_entity_id,  -- Identificador da entidade de negócios
    bc.personid as person_id,                    -- Identificador da pessoa associada à entidade
    bc.contacttypeid as contact_type_id,         -- Identificador do tipo de contato
    bc.rowguid as row_guid,                      -- Identificador único da linha
    cast(bc.modifieddate as date) as modified_date -- Data da última modificação no registro
from 
   {{ source('raw_adventure_works', 'businessentitycontact') }} as bc
-- Tabela associando pessoas a tipos de contato para entidades de negócios.
)
select *
from cc