
{{ config(materialized='table') }}

with
    st_history as (

select 

    st_history.businessentityid as business_entity_id,  -- Identificador da entidade de negócios
    st_history.territoryid as territory_id,              -- Identificador do território
    cast(st_history.startdate as date) as start_date,                  -- Data de início da associação ao território
    cast(st_history.enddate as date) as end_date,                      -- Data de término da associação ao território
    st_history.rowguid as row_guid,                      -- Identificador único da linha
    cast(st_history.modifieddate  as date) as modified_date  -- Data da última modificação no registro
from {{ source('raw_adventure_works', 'salesterritoryhistory') }} as st_history
-- Tabela contendo histórico de associações de entidades de negócios a territórios de vendas.
)
select *
from st_history