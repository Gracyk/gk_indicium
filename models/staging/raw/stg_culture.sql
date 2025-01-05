
{{ config(materialized='table') }}

with
    c as (
         
select 
    c.cultureid as culture_id,         -- ID da cultura
    c.name as culture_name,            -- Nome da cultura
    cast(c.modifieddate as date) as modified_date    -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'culture') }} as c
-- Tabela que armazena informações sobre diferentes culturas.
)
select *
from c