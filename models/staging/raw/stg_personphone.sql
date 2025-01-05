
{{ config(materialized='table') }}

with
    p as (
        
select 
    p.businessentityid as business_entity_id,  -- Identificador da entidade de negócios
    p.phonenumber as phone_number,              -- Número de telefone
    p.phonenumbertypeid as phone_number_type_id, -- Identificador do tipo de telefone
    cast(p.modifieddate as date) as modified_date            -- Data da última modificação no registro
from 
   {{ source('raw_adventure_works', 'personphone') }} as p
-- Tabela contendo dados de telefones de pessoas.
)
select *
from p