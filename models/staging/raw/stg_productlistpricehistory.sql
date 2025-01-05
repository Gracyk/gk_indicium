{{ config(materialized='table') }}

with
    plph as (
         
select 
    plph.productid as product_id,                 -- ID do produto
    cast(plph.startdate as date) as start_date,                  -- Data de início
    cast(plph.enddate as date) as end_date,                      -- Data de término
    plph.listprice as list_price,                  -- Preço de lista
    cast(plph.modifieddate as date) as modified_date             -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'productlistpricehistory') }} as plph
-- Tabela que armazena o histórico de preços de lista dos produtos.

    )
    
select *
from plph