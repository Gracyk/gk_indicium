{{ config(materialized='table') }}

with
    sr as (
         
select 
    sr.salesreasonid as sales_reason_id,     -- ID do motivo de venda
    sr.name as name,                         -- Nome do motivo de venda
    sr.reasontype as reason_type,            -- Tipo de motivo de venda
    cast(sr.modifieddate as date) as modified_date -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'salesreason') }} as sr
-- Tabela que contém os motivos de venda.

)
select *
from sr