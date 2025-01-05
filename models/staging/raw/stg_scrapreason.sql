{{ config(materialized='table') }}

with
    sr as (
         
select 
    sr.scrapreasonid as scrap_reason_id,   -- ID do motivo do descarte
    sr.name as name,                       -- Nome do motivo do descarte
    cast(sr.modifieddate as date) as modified_date  -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'scrapreason') }} as sr
-- Tabela que armazena informações sobre motivos de descarte.

)
select *
from sr