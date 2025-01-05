
{{ config(materialized='table') }}

with
    e as (
select 
    e.businessentityid as business_entity_id,  -- Identificador da entidade de negócios
    e.emailaddressid as email_address_id,      -- Identificador único do endereço de e-mail
    e.emailaddress as email_address,            -- Endereço de e-mail
    e.rowguid as row_guid,                      -- Identificador único da linha
    cast(e.modifieddate as date) as modified_date  -- Data da última modificação no registr
from 
    {{ source('raw_adventure_works', 'emailaddress') }} as e
    -- Tabela contendo dados de endereços de e-mail.

)
select *
from e