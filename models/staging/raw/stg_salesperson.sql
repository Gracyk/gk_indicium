{{ config(materialized='table') }}

with
    sp as (
    -- Tabela que contém os dados de vendedores, com informações de vendas, comissão, bônus, etc.(sales person)
select 
    sp.businessentityid as business_entity_id,  -- Identificador da entidade comercial
    sp.territoryid as territory_id,              -- Identificador do território
    sp.salesquota as sales_quota,                -- Cota de vendas
    sp.bonus as bonus,                           -- Bônus
    sp.commissionpct as commission_pct,          -- Percentual de comissão
    sp.salesytd as sales_ytd,                    -- Vendas no ano até a data
    sp.saleslastyear as sales_last_year,         -- Vendas do ano passado
    sp.rowguid as row_guid,                      -- Identificador único da linha
    cast(sp.modifieddate as date) as modified_date -- Data da última modificação no registro
from  
    {{ source('raw_adventure_works', 'salesperson') }} as sp

)
select * 
from sp