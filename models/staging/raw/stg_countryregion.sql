
{{ config(materialized='table') }}

with
    cr as (
        
select 
    cr.countryregioncode as country_region_code,    -- Código da região ou país
    cr.name as name,                                -- Nome da região ou país
    cast(cr.modifieddate as date) as modified_date -- Data da última modificação no registro
from 
{{ source('raw_adventure_works', 'countryregion') }} as cr
-- Tabela contendo informações sobre regiões e países no sistema AdventureWorks.

)
select *
from cr