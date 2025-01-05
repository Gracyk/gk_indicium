{{ config(materialized='table') }}

with
    sop as (
         
select 
    sop.specialofferid as special_offer_id,    -- ID da oferta especial
    sop.productid as product_id,                -- ID do produto
    sop.rowguid as row_guid,                    -- GUID da linha
    cast(sop.modifieddate as date) as modified_date  -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'specialofferproduct') }} as sop
-- Tabela que contém os produtos associados às ofertas especiais.

)
select *
from sop