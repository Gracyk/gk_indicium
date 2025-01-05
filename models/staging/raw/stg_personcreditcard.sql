
{{ config(materialized='table') }}

with
    pcc as (
        -- Select que relaciona entidades comerciais/pessoas com cartões de crédito (person credit card)
select 
    pcc.businessentityid as business_entity_id, -- Identificador da entidade comercial
    pcc.creditcardid as credit_card_id,         -- Identificador do cartão de crédito
    cast(pcc.modifieddate as date) as modified_date           -- Data da última modificação no registro
from 
    {{ source('raw_adventure_works', 'personcreditcard') }}  as pcc

)
select *
from pcc