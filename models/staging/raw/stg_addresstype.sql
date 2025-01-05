
{{ config(materialized='table') }}

with
    at as (

select 
    at.addresstypeid as address_type_id,   -- ID do tipo de endereço
    at.name as name,                       -- Nome do tipo de endereço
    at.rowguid as row_guid,                -- Identificador único global
    cast(at.modifieddate as date) as modified_date -- Data da última modificação no registro
from 
{{ source('raw_adventure_works', 'addresstype') }} as at
-- Tabela que contém os tipos de endereço (ex: residencial, comercial) no sistema AdventureWorks.
)
select *
from at