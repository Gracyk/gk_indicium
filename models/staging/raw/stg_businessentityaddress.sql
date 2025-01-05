
{{ config(materialized='table') }}

with
    bea as (
       
select 
    bea.businessentityid as business_entity_id,  -- Identificador único da entidade de negócios
    bea.addressid as address_id,                  -- Identificador único do endereço
    bea.addresstypeid as address_type_id,         -- Tipo do endereço (residencial, comercial, etc.)
    bea.rowguid as row_guid,                      -- GUID único para identificar a linha
    cast(bea.modifieddate as date) as modified_date -- Data da última modificação no registro
from 
   {{ source('raw_adventure_works', 'businessentityaddress') }} as bea
    -- Tabela associando as entidades de negócios com seus respectivos endereços.

)
select *
from bea