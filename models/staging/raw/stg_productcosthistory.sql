
{{ config(materialized='table') }}

with
    pch as (
         -- seleciona dados de Cartão de crédito  (credit card) 
select 

    pch.productid as product_id,           -- ID do produto
    cast(pch.startdate as date) as start_date,           -- Data de início do custo do produto
    cast(pch.enddate as date) as end_date,               -- Data de término do custo do produto
    pch.standardcost as standard_cost,     -- Custo padrão do produto
    cast(pch.modifieddate as date) as modified_date      -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'productcosthistory') }} as pch
-- Tabela que armazena o histórico de custos dos produtos.
)
select *
from pch