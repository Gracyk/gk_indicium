
{{ config(materialized='table') }}

with
    l as (
         
select 
    l."locationid" as location_id,           -- ID da localização
    l."name" as location_name,               -- Nome da localização
    l."costrate" as cost_rate,               -- Taxa de custo da localização
    l."availability" as availability,        -- Disponibilidade da localização
   cast(l."modifieddate" as date) as modified_date         -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'location') }} as l
-- Tabela que armazena informações sobre as localizações.
)
select *
from l