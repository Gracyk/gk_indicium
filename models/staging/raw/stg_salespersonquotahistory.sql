
{{ config(materialized='table') }}

with
    sq_history as (
SELECT
    sq_history.businessentityid as business_entity_id,  -- Identificador da entidade de negócios
    cast(sq_history.quotadate as date) as quota_date,      -- Data da cota de vendas
    sq_history.salesquota as sales_quota,                -- Valor da cota de vendas
    sq_history.rowguid as row_guid,                      -- Identificador único da linha
    cast(sq_history.modifieddate as date) as modified_date   -- Data da última modificação no registro
from {{ source('raw_adventure_works', 'salespersonquotahistory') }} as sq_history
-- Tabela contendo o histórico de cotas de vendas de vendedores.
)
select *
from  sq_history
