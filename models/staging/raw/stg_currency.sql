
{{ config(materialized='table') }}

with
    c as (
-- seleciona dados de moedas (currency)
select 
    c.currencycode as currency_code,       -- Código da moeda (ISO 3 letras)
    c.name as name,                        -- Nome da moeda
    cast(c.modifieddate as date) as modified_date         -- Data da última modificação
    
    from {{ source('raw_adventure_works', 'currency') }} as c
)
select *
from c