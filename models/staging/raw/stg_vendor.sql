
{{ config(materialized='table') }}

with
    v as (

select 
    v.businessentityid as business_entity_id,  -- ID da entidade de negócios
    v.accountnumber as account_number,         -- Número da conta do fornecedor
    v.name as name,                            -- Nome do fornecedor
    v.creditrating as credit_rating,           -- Classificação de crédito do fornecedor
    v.preferredvendorstatus as preferred_vendor_status,  -- Status de fornecedor preferencial
    v.activeflag as active_flag,               -- Indicador de fornecedor ativo (TRUE/FALSE)
    v.purchasingwebserviceurl as purchasing_web_service_url,  -- URL do serviço web de compras
    cast(v.modifieddate as date) as modified_date            -- Data da última modificação
from 
{{ source('raw_adventure_works', 'vendor') }} as v
-- Tabela que contém os fornecedores e informações relacionadas no sistema AdventureWorks.
)
select *
from v