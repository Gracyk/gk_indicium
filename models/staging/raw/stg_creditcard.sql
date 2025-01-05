
{{ config(materialized='table') }}

with
    cc as (
         -- seleciona dados de Cartão de crédito  (credit card) 
select 
    cc.creditcardid as credit_card_id,   -- Identificador único do cartão de crédito
    cc.cardtype as card_type,           -- Tipo do cartão de crédito (ex: Visa, Mastercard)
    cc.cardnumber as card_number,       -- Número do cartão de crédito
    cc.expmonth as expiration_month,    -- Mês de expiração do cartão
    cc.expyear as expiration_year,      -- Ano de expiração do cartão
    cast(cc.modifieddate as date) as modified_date      -- Data da última modificação no registro
from 
    {{ source('raw_adventure_works', 'creditcard') }} as cc
)
select *
from cc