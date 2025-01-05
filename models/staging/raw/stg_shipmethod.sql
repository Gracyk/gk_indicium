
{{ config(materialized='table') }}

with
    sm as (
        
select 
    sm.shipmethodid as ship_method_id,                  -- ID do método de envio
    sm.name as ship_method_name,                         -- Nome do método de envio
    sm.shipbase as ship_base,                            -- Taxa base do envio
    sm.shiprate as ship_rate,                            -- Taxa do envio por unidade
    sm.rowguid as row_guid,                              -- Identificador único da linha
    cast(sm.modifieddate as date) as modified_date        -- Data da última modificação do método de envio
from 
   {{ source('raw_adventure_works', 'shipmethod') }} as sm
    -- Tabela que contém os métodos de envio no sistema AdventureWorks.
)
select *
from sm