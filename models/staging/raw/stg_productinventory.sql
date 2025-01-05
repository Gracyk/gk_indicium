
{{ config(materialized='table') }}

with
    pi as (
         
select 
    pi.productid as product_id,          -- ID do produto
    pi.locationid as location_id,        -- ID da localização do estoque
    pi.shelf as shelf,                   -- Estante onde o produto está armazenado
    pi.bin as bin,                       -- Bin (compartimento) onde o produto está armazenado
    pi.quantity as quantity,             -- Quantidade do produto no estoque
    pi.rowguid as row_guid,              -- Identificador único da linha
    cast(pi.modifieddate as date) as modified_date     -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'productinventory') }} as pi
-- Tabela que armazena informações de inventário de produtos.

)
select *
from pi