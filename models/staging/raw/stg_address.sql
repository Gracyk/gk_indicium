
{{ config(materialized='table') }}

with
    a as (
        -- -- seleciona dados de Cartão de crédito  (credit card) 
select 
    a.addressid as address_id,                          -- Identificador único do endereço
    a.addressline1 as address_line_1,                    -- Primeira linha do endereço
    a.addressline2 as address_line_2,                    -- Segunda linha do endereço
    a.city as city,                                      -- Cidade do endereço
    a.stateprovinceid as state_province_id,              -- Identificador do estado ou província
    a.postalcode as postal_code,                         -- Código postal do endereço
    a.spatiallocation as spatial_location,               -- Localização geoespacial do endereço
    a.rowguid as row_guid,                               -- GUID único para identificar a linha
    cast(a.modifieddate as date) as modified_date        -- Data da última modificação no registro
from 
{{ source('raw_adventure_works', 'address') }} as a 
-- Tabela contendo informações sobre os endereços dos clientes e entidades de negócios.

)
select *
from a