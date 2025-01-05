
{{ config(materialized='table') }}

with
    st as (

select 
    st.territoryid as territory_id,            -- Identificador do território
    st.name as territory_name,                 -- Nome do território
    st.countryregioncode as country_region_code, -- Código do país ou região
    st."group" as territory_group,               -- Grupo do território
    st.salesytd as sales_ytd,                  -- Vendas no ano até a data
    st.saleslastyear as sales_last_year,       -- Vendas do ano passado
    st.costytd as cost_ytd,                    -- Custo no ano até a data
    st.costlastyear as cost_last_year,         -- Custo do ano passado
    st.rowguid as row_guid,                    -- Identificador único da linha
   cast(st.modifieddate  as date) as modified_date  -- Data da última modificação no registro
 from  {{ source('raw_adventure_works', 'salesterritory') }} as st
-- Tabela que contém os dados de territórios de vendas, com informações sobre vendas, custos, etc.
    )
select * 
from st