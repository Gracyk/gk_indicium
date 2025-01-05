{{ config(materialized='table') }}

with
    so as (
         
select 
    so.specialofferid as special_offer_id,       -- ID da oferta especial
    so.description as description,               -- Descrição da oferta especial
    so.discountpct as discount_pct,              -- Percentual de desconto
    so.type as offer_type,                       -- Tipo da oferta
    so.category as category,                     -- Categoria da oferta
    cast(so.startdate as date) as start_date,                  -- Data de início da oferta
    cast(so.enddate as date) as end_date,                      -- Data de término da oferta
    so.minqty as min_qty,                        -- Quantidade mínima para a oferta
    so.maxqty as max_qty,                        -- Quantidade máxima para a oferta
    so.rowguid as row_guid,                      -- GUID da linha
    cast(so.modifieddate as date) as modified_date            -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'specialoffer') }} as so
-- Tabela que contém informações sobre as ofertas especiais.

)
select *
from so