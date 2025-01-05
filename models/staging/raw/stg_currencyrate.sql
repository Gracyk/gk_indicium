
{{ config(materialized='table') }}

with
    cr as (
      -- seleciona dados de taxas de câmbio entre diferentes moedas (currency rate)
select 
    cr.currencyrateid as currency_rate_id,           -- id da taxa de câmbio
    cast(cr.currencyratedate as date) as currency_rate_date,       -- data da taxa de câmbio
    cr.fromcurrencycode as from_currency_code,       -- código da moeda de origem
    cr.tocurrencycode as to_currency_code,           -- código da moeda de destino
    cr.averagerate as average_rate,                  -- taxa média de câmbio
    cr.endofdayrate as end_of_day_rate,              -- taxa de câmbio no final do dia
    cast(cr.modifieddate as date) as modified_date                 -- data da última modificação
from
      {{ source('raw_adventure_works', 'currencyrate') }} as cr -- taxa de câmbio
 
 )

select *
from cr