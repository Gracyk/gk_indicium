
{{ config(materialized='table') }}

with
    pd as (
        
select 
    pd.productdescriptionid as product_description_id,  -- ID da descrição do produto
    pd.description as product_description,               -- Descrição do produto
    pd.rowguid as row_guid,                               -- GUID único da linha
    cast(pd.modifieddate as date) as modified_date      -- Data da última modificação
from 
   {{ source('raw_adventure_works', 'productdescription') }} as pd
    -- Tabela que armazena descrições de produtos.

)
select *
from pd