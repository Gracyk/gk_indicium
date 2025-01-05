
{{ config(materialized='table') }}

with
    sp as (
       
select 
    sp.stateprovinceid as state_province_id,                  -- Identificador único do estado ou província
    sp.stateprovincecode as state_province_code,              -- Código do estado ou província
    sp.countryregioncode as country_region_code,              -- Código do país ou região
    sp.isonlystateprovinceflag as is_only_state_province_flag, -- Flag indicando se é o único estado/província na região
    sp.name as name,                                          -- Nome do estado ou província
    sp.territoryid as territory_id,                           -- Identificador da região de vendas
    sp.rowguid as row_guid,                                    -- GUID único para identificar a linha
    cast(sp.modifieddate as date) as modified_date             -- Data da última modificação no registro
from 
   {{ source('raw_adventure_works', 'stateprovince') }} as sp
  -- Tabela contendo informações sobre estados ou províncias e suas regiões associadas.

)
select *
from sp