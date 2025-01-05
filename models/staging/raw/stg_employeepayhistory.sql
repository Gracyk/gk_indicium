{{ config(materialized='table') }}

with
    eph as (
         
select 
    eph.businessentityid as business_entity_id,  -- ID da entidade de negócios
    cast(eph.ratechangedate as date) as rate_change_date,       -- Data de alteração da taxa
    eph.rate as rate,                             -- Taxa
    eph.payfrequency as pay_frequency,            -- Frequência de pagamento
    cast(eph.modifieddate as date) as modified_date   -- Data da última modificação
from     
   {{ source('raw_adventure_works', 'employeepayhistory') }} as eph
-- Tabela que contém histórico de pagamento dos funcionários.


)
select *
from eph