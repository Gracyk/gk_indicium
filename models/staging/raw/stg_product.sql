
{{ config(materialized='table') }}

with
    p as (
         -- seleciona dados de Cartão de crédito  (credit card) 
select 

    p.productid as product_id,                            -- ID do produto
    p.name as product_name,                               -- Nome do produto
    p.productnumber as product_number,                    -- Número do produto
    p.makeflag as make_flag,                              -- Indicador se o produto é fabricado
    p.finishedgoodsflag as finished_goods_flag,           -- Indicador se o produto é bem acabado
    p.color as color,                                     -- Cor do produto
    p.safetystocklevel as safety_stock_level,             -- Nível de estoque de segurança
    p.reorderpoint as reorder_point,                      -- Ponto de reabastecimento
    p.standardcost as standard_cost,                      -- Custo padrão do produto
    p.listprice as list_price,                            -- Preço de lista do produto
    p.size as size,                                       -- Tamanho do produto
    p.sizeunitmeasurecode as size_unit_measure_code,      -- Código da unidade de medida para o tamanho
    p.weightunitmeasurecode as weight_unit_measure_code,  -- Código da unidade de medida para o peso
    p.weight as weight,                                   -- Peso do produto
    p.daystomanufacture as days_to_manufacture,           -- Número de dias para fabricação
    p.productline as product_line,                        -- Linha de produto
    p.class as class,                                     -- Classe do produto
    p.style as style,                                     -- Estilo do produto
    p.productsubcategoryid as product_subcategory_id,     -- ID da subcategoria do produto
    p.productmodelid as product_model_id,                 -- ID do modelo de produto
    cast(p.sellstartdate as date) as sell_start_date,                   -- Data de início da venda
    cast(p.sellenddate as date) as sell_end_date,                       -- Data de término da venda
    p.discontinueddate  as discontinued_date,              -- Data de descontinuação do produto
    p.rowguid as row_guid,                                -- Identificador único da linha
    cast(p.modifieddate as date) as modified_date                       -- Data da última modificação
    from 
        {{ source('raw_adventure_works', 'product') }} as p
    -- Tabela que contém informações sobre os produtos no sistema AdventureWorks.
)
select *
from p